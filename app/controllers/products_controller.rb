class ProductsController < ApplicationController
    def index
    
    end
  
    def new
      @product = Product.new
    end
  
    def create
      Product.create(product_params)
      redirect_to root_path
    end
  
    private
    def product_params
      params.require(:product).permit(:name,:price,:explanation,:size,:quality,:shipping_charge,:delivery_date,:trading_status,:area)
    end
end
