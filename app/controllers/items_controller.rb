class ItemsController < ApplicationController
  require 'payjp'
  def index
    @products = Product.includes([:images, :user]).last(4).reverse

    @products2 = Product.where(category_id:3).last(4).reverse

  end

  def items
    @products = Product.includes([:images, :user]).order('created_at desc')
  end

  def purchase
    @product = Product.find(params[:product_id])
  end

  def create
    # binding.pry
  end

  def sold
    @product = Product.find(params[:product_id])
    @purchase = Purchase.new(user_id: current_user.id, product_id: params[:product_id])
    @purchase.save
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    Payjp::Charge.create(
      amount: @product.price, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy')
    @product.trading_status = '売り切れ'
    @product.save
  end
end
