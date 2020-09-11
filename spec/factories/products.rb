FactoryBot.define do

  factory :product do
    association :category
    name  {"test_item"}
    price {1000}
    explanation {"これは動作テスト用の商品です"}
    quality_id {1}
    shipping_charge_id {1}
    delivery_date_id {1}
    trading_status {"出品中"}
    area_id {1}
    user_id {1}
    brand_id {nil}
    after(:build) do |product|                          
      product.images << build(:image) 
    end  
  end

end