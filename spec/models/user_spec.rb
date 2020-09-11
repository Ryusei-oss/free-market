require 'rails_helper'

describe User do
  describe '#create' do

    it "名前, カナ名, 誕生日, ニックネーム, 電話番号, email, パスワード
    が存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "パスワード７文字未満はNG" do
      user = build(:user, password: "1111", password_confirmation: "1111")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    it "確認用パスワードが間違っている" do
      user = build(:user, password: "11111111", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

#=====================================================================================
#   一意性のテスト
#=====================================================================================
    it "email一意性チェック" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

#=====================================================================================
#   Not Null 制約のテスト
#=====================================================================================
    it "last_nameがない場合は登録できないこと" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "first_nameがない場合は登録できないこと" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "last_name_kanaがない場合は登録できないこと" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    it "first_name_kanaがない場合は登録できないこと" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "nikcnameがない場合は登録できないこと" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "birthdayがない場合は登録できないこと" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    it "tellがない場合は登録できないこと" do
      user = build(:user, tell: nil)
      user.valid?
      expect(user.errors[:tell]).to include("can't be blank")
    end

  end
end