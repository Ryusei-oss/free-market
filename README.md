# README

## DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
|nickname|string|null: false,|
|mail|string|null: false,unique:true|
|password|string|null: false|
|tell|string|null: false|
|icon|string||
|address_id|references|null: false,foreign_key: true|
|creditcard_id|references|null: false,foreign_key: true|
### Association
- has_many: products
- has_many: comments
- has_many: purchases
- has_many: likes
- belongs_to: addresses
- belongs_to: creditcards

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|product_name|string|null: false|
|price|integer|null: false|
|explanation|text|null: false|
|size|string|null: false|
|quality|string|null: false|
|shipping_charge|string|null: false|
|delivery_date|string|null: false|
|trading_status|string|null: false|
|area|string|null: false|
|user_id|references|null: false,foreign_key: true|
|category_id|references|null: false,foreign_key: true|
|brand_id|references|null: false,foreign_key: true|
|like_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user
- belongs_to: purchases
- has_many: comments
- has_many: images
- has_many: likes
- belongs_to: brand
- has_many :categories, through: :products_categories

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|category|string|null: false|
|product_id|references|null: false,foreign_key: true|
### Association
- has_many: products, through: :products_categories

## products_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|null: false,foreign_key: true|
|category_id|integer|null: false,foreign_key: true|
### Association
- belongs_to: product
- belongs_to: category

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|brand|string||
|product_id|references|null: false,foreign_key: true|
### Association
- has_many: products

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text||
|user_id|references|null: false,foreign_key: true|
|product_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user
- belongs_to: product

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|product_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user
- belongs_to: product

## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|card_month|integer|null: false|
|card_year|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|area|string|null: false|
|city|string|null: false|
|house_number|integer|null: false|
|building|string||
|user_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user

## purchaseテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|product_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user
- belongs_to: product

## images テーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product_id|references|null: false,foreign_key: true|
### Association
- belongs_to: product