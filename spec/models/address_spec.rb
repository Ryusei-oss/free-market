require 'rails_helper'

# RSpec.describe Address, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
#   let(:user) { FactoryBot.create(:user) }
#   let(:address) { FactoryBot.create(:address, user_id: user.id) }
# end
describe Address do
  describe '#create' do
    it "" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "Check postal_code Nil" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end
  end
end