require 'rails_helper'

describe UsersController do
  
  describe 'GET #show' do
    before do
      @user = create(:user)
    end
    it "show.html.hamlに遷移すること" do
      sign_in @user
      get :show, params: {id: @user.id}
      expect(response).to be_success
    end
  end
  
end