FactoryBot.define do

  factory :product do
    name  {"test_item"}
    price {1000}
    explanation {"これは動作テスト用の商品です"}
    quality_id {1}
    shipping_charge_id {1}
    delivery_date_id {1}
    trading_status {"出品中"}
    area_id {1}
    #created_at: 2020-01-01
    #updated_at: 2020-01-02
    user_id {1}
    category_id {3}
    brand_id {nil}
  end

end