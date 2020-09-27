class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update]
  before_action :set_category_ancestry, only: [:new, :edit]
  
    def index
      @products = Product.includes(:images).order('created_at DESC')
    end
    def show
      @category = Category.all.order("id ASC").limit(13)
      @same_category = Category.where(params[:id])
      @grandchild_category = @product.category
      @child_category = @grandchild_category.parent
      @parent_category = @product.category.parent.parent

      if @product.brand_id
        @brand = Bland.find(@product.brand_id)
      end
    end

    def new
      if !current_user
        redirect_to root_path
      end
      @product = Product.new
      @product.images.new
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
  
    def edit
      @grandchild_category = @product.category
      @child_category = @grandchild_category.parent 

      @parent_category = @product.category.parent.parent
      @category_children = @product.category.parent.parent.children
      @category_grandchildren = @product.category.parent.children
    end

    def update
      if @product.update(update_params)
        redirect_to product_path(@product)
      else
        render :edit
      end
    end



    def destroy
      if @product.destroy
        redirect_to root_path
      else
        render :edit
      end
    end

    def category_children
      @category_children = Category.find("#{params[:parent_id]}").children
    end

    def category_grandchildren
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def set_category_ancestry
      @category_parent = Category.where("ancestry is null")
    end

    def product_params
      params.require(:product).permit(:name,:price,:explanation,:quality_id,:shipping_charge_id,:delivery_date_id,:trading_status,:area_id, :category_id, :brand_id, images_attributes: [:image]).merge(user_id: current_user.id)
    end

    def update_params
      params.require(:product).permit(:name,:price,:explanation,:quality_id,:shipping_charge_id,:delivery_date_id,:trading_status,:area_id, :category_id, :brand_id, [images_attributes: [:image, :_destroy, :id]]).merge(user_id: current_user.id)
    end

end
