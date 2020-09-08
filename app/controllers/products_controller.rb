class ProductsController < ApplicationController
    def index
      @products = Product.includes(:images).order('created_at DESC')
    end
  
    def new
      @product = Product.new
      @product.images.new
      @category_parent = Category.where("ancestry is null")
    end
  
    def create
      @product = Product.new(product_params)
      if !@product.save
        redirect_to new_product_path
      elsif
        respond_to do |format|
          format.html { redirect_to :root }
          format.json { render json: @product}
        end
      end
    end
  
    def category_children
      @category_children = Category.find("#{params[:parent_id]}").children
    end

    def category_grandchildren
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end

    private
    def product_params
      params.require(:product).permit(:name,:price,:explanation,:quality_id,:shipping_charge_id,:delivery_date_id,:trading_status,:area_id, :category_id, images_attributes: [:image]).merge(user_id: current_user.id)
    end
end
