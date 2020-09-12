class ItemsController < ApplicationController

  def index
    @products = Product.includes([:images, :user]).last(4).reverse

    @products2 = Product.where(category_id:1).last(4).reverse

  end

  def items
    @products = Product.includes([:images, :user]).order('created_at desc')
  end



end
