require 'rails_helper'

describe CardsController do
  describe "POST #create" do
    before do
      @user = create(:user)
    end
    it "カード情報のトークン化 ＋ 登録まで" do
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
      expect{card.save}.to change(Card, :count).by(1)
    end

    describe 'GET #new' do
      it "new.html.hamlに遷移すること" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #show' do
      it "show.html.hamlに遷移すること" do
        get :show
        expect(response).to render_template :show
      end
    end
  end
end