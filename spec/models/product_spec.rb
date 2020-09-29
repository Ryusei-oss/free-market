require 'rails_helper'

describe Product do
  
  describe '#create' do
    it "正常の動作" do
      product = build(:product)
      expect(product).to be_valid
    end
    #======= not null 制約のチェック

    #name: nilの時にエラー
    it "nameがない場合は登録できないこと" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    #explanation: nilの時にエラー
    it "explanationがない場合は登録できないこと" do
      product = build(:product, explanation: nil)
      product.valid?
      expect(product.errors[:explanation]).to include("can't be blank")
    end

    #quility_id: nilの時にエラー
    it "quality_idがない場合は登録できないこと" do
      product = build(:product, quality_id: nil)
      product.valid?
      expect(product.errors[:quality_id]).to include("can't be blank")
    end

    #shipping_charge_id: nilの時にエラー
    it "shipping_idがない場合は登録できないこと" do
      product = build(:product, shipping_charge_id: nil)
      product.valid?
      expect(product.errors[:shipping_charge_id]).to include("can't be blank")
    end

    #area_id: nilの時にエラー
    it "area_idがない場合は登録できないこと" do
      product = build(:product, area_id: nil)
      product.valid?
      expect(product.errors[:area_id]).to include("can't be blank")
    end

    #delivery_date_id: nilの時にエラー
    it "delivery_date_idがない場合は登録できないこと" do
      product = build(:product, delivery_date_id: nil)
      product.valid?
      expect(product.errors[:delivery_date_id]).to include("can't be blank")
    end

    #price: nilの時にエラー
    it "priceがない場合は登録できないこと" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("is not a number")
    end

    #user: nilのときにエラー ユーザーマイページをマージしたら実装
    # it "userがない場合は登録できないこと" do
    #   product = build(:user_id, name: nil)
    #   product.valid?
    #   expect(product.errors[:user_id]).to include("can't be blank")
    # end

    #category_id: nilの時にエラー
    it "category_idがない場合は登録できないこと" do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("must exist")
    end
  end  

  describe '#update' do
    # 1.変更可能な項目が存在すれば登録できること
    it "商品の編集保存が可能なこと" do
      product = build(:product)
      expect(product).to be_valid
    end

    # 2.nameが空だと登録できないこと
    it "nameがない場合は登録できないこと" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    # 3.explanationが空だと登録できないこと
    it "explanationがない場合は登録できないこと" do
      product = build(:product, explanation: nil)
      product.valid?
      expect(product.errors[:explanation]).to include("can't be blank")
    end

    # 4.priceが空だと登録できないこと
    it "priceがない場合は登録できないこと" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("is not a number")
    end
  end



    #=======その他バリデーション違反のチェック

    #name: 名前40文字以上の時にエラー
    it "explanationが1000字以上のときにエラー" do
      product = build(:product, name: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      product.valid?
      expect(product.errors[:name]).to include("is too long (maximum is 40 characters)")
    end
    #explanation: 1000文字以上の時にエラー
    it "explanationが1000字以上のときにエラー" do
      product = build(:product, explanation: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      product.valid?
      expect(product.errors[:explanation]).to include("is too long (maximum is 1000 characters)")
    end
  end


#image: nilの時にエラー
describe Image do
  describe '#create' do
    it "imageがない場合は登録できないこと" do
      product = build(:product)
      product.images[0].image = nil
      img = product.images[0]
      img.valid?
      expect(img.errors[:image]).to include("can't be blank")
    end
  end 

  describe '#update' do
    it "imageがない場合は登録できないこと" do
      product = build(:product)
      product.images[0].image = nil
      img = product.images[0]
      img.valid?
      expect(img.errors[:image]).to include("can't be blank")
    end
  end
end 
