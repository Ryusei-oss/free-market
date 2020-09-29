require 'rails_helper'

RSpec.describe Card, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "create" do
    before do
      @user = create(:user)
    end
    #=============================================================
    # OK時のテスト
    #=============================================================
    it "When all param corrects" do
      card = build(:card, user: @user)
      expect(card).to be_valid
    end
    #=============================================================
    # Nilデータ入っている時のテスト
    #=============================================================
    it "when card_id eq nil" do
      card = build(:card, user: @user, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("can't be blank")
    end

    it "when customer_id eq nil" do
      card = build(:card, user: @user, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("can't be blank")
    end

    it "when user_id eq nil" do
      card = build(:card)
      card.valid?
      expect(card.errors[:user_id]).to include("can't be blank")
    end
  end
end
