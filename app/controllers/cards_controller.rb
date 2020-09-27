class CardsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_payjp_key, except: :new

  def index
    if current_user.cards.present?
      @cards = Card.where(user_id: current_user.id)
    end
  end

  def new
  end

  def create
    if !params_payjp[:payjp_token]
      return
    end
    begin 
      customer = Payjp::Customer.create(card: params_payjp[:payjp_token]) 
      #Card DBへの登録
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      @card.save
      redirect_to user_path(current_user)
    rescue Payjp::InvalidRequestError
      render "new"
    end
  end

  def destroy
    card = Card.find(params[:id])
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to user_path(current_user)
  end

  private

  def set_payjp_key
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
  end

  def params_payjp
    params.permit(:"security-code", :payjp_token)
  end
end