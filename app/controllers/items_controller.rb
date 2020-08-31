class ItemsController < ApplicationController
  def index
    @category = Category.all.order("id ASC").limit(4)
  end

end
