require 'rails_helper'

describe ProductsController do
  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before do
      @category = create(:category)
      @product_params = attributes_for(:product)
    end
    it '商品が正しく登録されること' do
      # binding.pry
      expect{ post :create, params: { product: @product_params, category_id: @category.id } }.to change(Product, :count).by(1)
    end

    it '商品が正しく登録されないこと' do
      product_params = attributes_for(:product, :invalid)
      expect{ post :create, params: { product: product_params } }.to_not change(Product, :count).by(1)
    end

    it "root_pathに遷移すること" do
      product_params = attributes_for(:product)
      post :create, params: { product: product_params }
      expect(response).to redirect_to(root_path)
    end

    it "new.html.hamlに遷移すること" do
      product_params = attributes_for(:product, :invalid)
      post :create, params: { product: product_params }
      expect(response).to render_template :new
    end
  end
end