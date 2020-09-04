require 'rails_helper'

describe Product do
  describe '#create' do


#正常動作

#======= not null 制約のチェック

#name: nilの時にエラー
it "nicknameがない場合は登録できないこと" do
  product = build(:product, name: nil)
  product.valid?
  expect(product.errors[:name]).to include("can't be blank")
end
#explanation: nilの時にエラー
#quility_id: nilの時にエラー
#shipping_charge_id: nilの時にエラー
#area_id: nilの時にエラー
#delivery_date_id: nilの時にエラー
#price: nilの時にエラー
#user: nilのときにエラー
#category_id: nilの時にエラー
#image: nilの時にエラー

#=======その他バリデーション違反のチェック

#name: 名前40文字以上の時にエラー
#explanation: 1000文字以上の時にエラー
#quality_id = 0? のときにエラー
#shipping_charge_id = 0? のときにエラー
#area_id = 0? のときにエラー
#delivery_date_id = 0? のときにエラー
#price: 300 < price || 10000000 < price でエラー
  end
end