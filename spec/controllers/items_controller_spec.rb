require 'rails_helper'

describe ItemsController do
  describe "POST #sold" do
    before do
      @user = create(:user)
      @product = create(:product, user: @user)
    end

    describe 'GET #purchase' do
      it "purchase.html.hamlに遷移すること" do
        sign_in @user
        get :purchase, params: {product_id: @product.id, user: @user}
        expect(response).to render_template :purchase
      end

      it "購入記録のデータベースへの反映が正しくできる" do
        @purchase = Purchase.new(user_id: @user.id, product_id: @product.id)
        expect{@purchase.save}.to change(Purchase, :count).by(1)
      end
    end

    describe 'POST #sold' do
      it "登録失敗時に product_sold_pathに遷移すること" do
        sign_in @user
        @purchase = Purchase.new(user_id: @user.id, product_id: @product.id)
        post :sold, params: {purchase: @purchase, product_id: @product.id}
        binding.pry
        expect(response).to redirect_to(items_path)
      end
    end
  end
end