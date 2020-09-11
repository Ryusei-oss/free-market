class ItemsController < ApplicationController

  def index
    @products = Product.includes([:images, :user]).last(3).reverse
    @images = Image.all
  end

  def items
    @products = Product.includes([:images, :user]).order('created_at desc')
  end



end
