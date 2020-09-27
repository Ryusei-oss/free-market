require 'rails_helper'

describe CardsController do
  before do
    @user = create(:user)
    create_token_payjp
  end

  describe 'GET #index' do
    it "index.html.hamlに遷移すること" do
      sign_in @user
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    it "Payjpへカード情報のトークン化 ~ DB登録ができる" do
      customer = Payjp::Customer.create(card: @token_payjp)
      card = Card.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
      expect{card.save}.to change(Card, :count).by(1)
    end
  
    it "Card DB登録成功時には./user/show.html.hamlに遷移すること" do
      sign_in @user
      post :create, params:{payjp_token: @token_payjp.id}
      expect(response).to redirect_to user_path(@user.id)
    end  
  
    it "Payjp カード登録失敗時にはnew.html.hamlに遷移すること" do
      sign_in @user 
      post :create, params:{payjp_token: @token_payjp.id}
      post :create, params:{payjp_token: @token_payjp.id}
      expect(response).to render_template :new
    end
  end

  describe "DELETE #destroy" do
    it "正常に削除できる" do
      sign_in @user
      post :create, params:{payjp_token: @token_payjp.id}
      card = Card.find_by(user_id: @user.id)
      expect{card.destroy}.to change{Card.count}.by(-1)
    end
  end

end

def create_token_payjp
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
end