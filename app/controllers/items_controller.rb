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
    card = Card.where(user_id: current_user.id)
    binding.pry
    if !card.present?
      redirect_to items_path
    end
    @product = Product.find(params[:product_id])
    
  end

  def create
    @cards = Card.where(user_id: current_user.id)
  end

  def sold
    @product = Product.find(params[:product_id])
    @purchase = Purchase.new(user_id: current_user.id, product_id: params[:product_id])
    @purchase.save
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    @card = Card.find_by(user_id: current_user.id)
    begin
      Payjp::Charge.create(
        amount: @product.price, # 決済する値段
        customer: @card.customer_id, # フォームを送信すると作成・送信されてくるトークン
        currency: 'jpy')
      @product.trading_status = '売り切れ'
      @product.save
    rescue Payjp::InvalidRequestError
      redirect_to items_path
    end
  end
end
