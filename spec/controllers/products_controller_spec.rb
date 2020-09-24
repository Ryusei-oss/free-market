require 'rails_helper'

describe ProductsController do
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      sign_in(user)
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it "商品が正しく登録されること" do
      sign_in(user)
      product_params = attributes_for(:product, category_id: category.id)
      expect{ post :create, params: { product: product_params } }.to change(Product, :count).by(1)
    end

    it "登録成功時に root_pathに遷移すること" do
      sign_in(user)
      product_params = attributes_for(:product, category_id: category.id)
      post :create, params: { product: product_params }
      expect(response).to redirect_to(root_path)
    end

    it "登録失敗時に new.html.hamlに遷移すること" do
      sign_in(user)
      product_params = attributes_for(:product)
      post :create, params: { product: product_params }
      expect(response).to redirect_to new_product_path
    end
  end

  describe 'GET #edit' do
    it "編集画面に正しく遷移すること" do
      sign_in(user)
      product_params = attributes_for(:product, category_id: category.id)
      get :edit, params: { product: product_params }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it "編集成功時に商品詳細画面 product_pathに遷移すること" do
      sign_in(user)
      product_params = attributes_for(:product, category_id: category.id)
      patch :update, params: { product: product_params }
      expect(response).to render_template :show
    end

    it "編集失敗時に編集画面のまま留まっているか" do
      sign_in(user)
      product_params = attributes_for(:product)
      patch :update, params: { product: product_params }
      expect(response).to render_template :edit
    end
  end
end