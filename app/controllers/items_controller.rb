class ItemsController < ApplicationController
  def index
    @category = Category.all
  end

end
