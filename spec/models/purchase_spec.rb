require 'rails_helper'

RSpec.describe Purchase, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "create" do
    before do
      @user = create(:user)
      category = create(:category)
      @product = create(:product, user: @user, category: category)
      @user2 = create(:tanaka)
    end
    #=============================================================
    # OK時のテスト
    #=============================================================
    it "When all param corrects" do
      purchase = build(:purchase, user: @user, product: @product)
      expect(purchase).to be_valid
    end
    #=============================================================
    # Nilデータ入っている時のテスト
    #=============================================================
    it "When user_id eq nil" do
      purchase = build(:purchase, product: @product)
      purchase.valid?
      expect(purchase.errors[:user_id]).to include("can't be blank")
    end

    it "When product_id eq nil" do
      purchase = build(:purchase, user: @user)
      purchase.valid?
      expect(purchase.errors[:product_id]).to include("can't be blank")
    end
  end
end
