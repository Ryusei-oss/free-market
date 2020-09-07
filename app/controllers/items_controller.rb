class ItemsController < ApplicationController
  def index
    #データベースへの反映がうまくいったらcategoriesテーブルのancestryカラムがnullになっている
    #一番最大のidをlimit()内に書く
    @category = Category.all.order("id ASC").limit(1)
  end

end
