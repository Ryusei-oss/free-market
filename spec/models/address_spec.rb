require 'rails_helper'

# RSpec.describe Address, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
#   let(:user) { FactoryBot.create(:user) }
#   let(:address) { FactoryBot.create(:address, user_id: user.id) }
# end
describe Address do
  describe '#create' do
#=============================================================================
#   OK時のテスト
#=============================================================================
    it "When all param corrects" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "When all param corrects" do
      address = build(:address, building: nil)
      expect(address).to be_valid
    end
#=============================================================================
#   Not Null パラメータにNilを含む時のNGテスト
#=============================================================================
    it "When postal_code = Nil" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    it "When area = Nil" do
      address = build(:address, area: nil)
      address.valid?
      expect(address.errors[:area]).to include("can't be blank")
    end

    it "When city = Nil" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    it "When house_numver = Nil" do
      address = build(:address, house_number: nil)
      address.valid?
      expect(address.errors[:house_number]).to include("can't be blank")
    end

    it "When user_id = Nil" do
      address = build(:address, user_id: nil)
      address.valid?
      expect(address.errors[:user_id]).to include()
    end


  end
end