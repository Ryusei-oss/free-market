require 'rails_helper'



describe ItemsController do
  before do
    @user = create(:user)
    @tanaka = create(:tanaka)
    @product = create(:product, user: @tanaka)
  end

  describe "GET #index" do
    it "index.html.hamlへ遷移できる" do
      sign_in @user
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #purchase' do
    before do
      sign_in @user
    end
    it "カードが登録されていない時は購入ページへ遷移できない" do
      get :purchase, params: {product_id: @product.id, user: @user}
      expect(response).to redirect_to items_path
    end
      it "カードが登録されている時は購入ページへ遷移できる" do
        register_card
        get :purchase, params: {product_id: @product.id, user: @user}
        expect(response).to render_template :purchase
      end
    it "二重支払いが生じないように売り切れの時はitems_pathに遷移する" do        
      @product.trading_status = '売り切れ'
      @product.save
      register_card
      get :purchase, params: {product_id: @product.id, user: @user}
      @product.trading_status = '売り切れ'
      expect(response).to redirect_to items_path
    end
  end

  describe "POST #sold" do
    before do 
      sign_in @user
      register_card
    end
    it "購入記録のデータベースへの反映が正しくできる" do
      @purchase = Purchase.new(user_id: @tanaka.id, product_id: @product.id)
      expect{@purchase.save}.to change(Purchase, :count).by(1)
    end

    it "購入成功時に product_sold_pathに遷移すること" do
      @purchase = Purchase.new(user_id: @user.id, product_id: @product.id)
      post :sold, params: {purchase: @purchase, product_id: @product.id}
      expect(response).to render_template :sold
    end

    it "購入成功時に productが売れ切れ状態になること" do
      @purchase = Purchase.new(user_id: @user.id, product_id: @product.id)
      post :sold, params: {product_id: @product.id}
      product = Product.find(@product.id)
      expect(product.trading_status).to eq "売り切れ"
    end

    it "二重支払いが生じないように売り切れの時はitems_pathに遷移する" do        
      @product.trading_status = '売り切れ'
      @product.save
      register_card
      get :purchase, params: {product_id: @product.id, user: @user}
      expect(response).to redirect_to items_path
    end
  end
end

def register_card
  Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
  @token_payjp = Payjp::Token.create({
  :card => {
    :number => '4242424242424242',
    :cvc => '123',
    :exp_month => '2',
    :exp_year => '2024'
  }},
  {
    'X-Payjp-Direct-Token-Generate': 'true'
  })
  customer = Payjp::Customer.create(card: @token_payjp)
  card = Card.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
  card.save
end