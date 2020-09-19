class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if current_user.cards.present?
      @cards = Card.where(user_id: current_user.id)
    end
  end

  def destroy
  end
  
end
