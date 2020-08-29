class ProductsController < ApplicationController
    def index
      @products = Product.includes(:images).order('created_at DESC')
    end
  
    def new
      @product = Product.new
      @product.images.new
    end
  
    def create
      @product = Product.create(product_params)
      respond_to do |format|
        format.html { redirect_to :root }
        format.json { render json: @product}
      end
    end
  
    private
    def product_params
      params.require(:product).permit(:name,:price,:explanation,:size,:quality,:shipping_charge,:delivery_date,:trading_status,:area, images_attributes: [:image])
    end
end
