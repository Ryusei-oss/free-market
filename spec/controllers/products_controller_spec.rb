require 'rails_helper'

describe ProductsController do
  let(:category) { create(:category) }

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it '商品が正しく登録されること' do
      product_params = attributes_for(:product, category_id: category.id)
      expect{ post :create, params: { product: product_params } }.to change(Product, :count).by(1)
    end

    it "登録成功時に root_pathに遷移すること" do
      product_params = attributes_for(:product, category_id: category.id)
      post :create, params: { product: product_params }
      expect(response).to redirect_to(root_path)
    end

    it "登録失敗時に new.html.hamlに遷移すること" do
      product_params = attributes_for(:product)
      post :create, params: { product: product_params }
      expect(response).to redirect_to new_product_path
    end
  end
end