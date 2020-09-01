require 'rails_helper'

describe AddressesController, type: :controller do
 
  describe 'GET #new' do
    before do
      @address = create(:address)
    end
    it "new.html.erbに遷移すること" do
      sign_in @address.user
      get :new, params: {user_id: @address.user_id}
      expect(response).to be_success
    end
  end

  describe 'Post #create' do
  before do
    @user = create(:user)
    @address = attributes_for(:address)
  end
    it "Saves the new address in the database" do
      sign_in @user
      expect{post :create, params:{address: @address, user_id: @user.id}}.to change(Address, :count).by(1)
    end
  end
end
