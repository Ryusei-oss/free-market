class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    Address.create(address_params)
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :area, :city, :house_number, :building).merge(user_id: current_user.id)
  end
end
