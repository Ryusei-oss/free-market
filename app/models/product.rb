class Product < ApplicationRecord
  validates :name, length: {maximum: 40}, presence: true
  validates :explanation, length: {maximum: 1000}, presence: true
  validates :quality_id, exclusion: {in: %w(選択してください) }
  validates :shipping_charge_id, exclusion: {in: %w(選択してください) }
  validates :area_id, exclusion: {in: %w(選択してください) }
  validates :delivery_date_id,  exclusion: {in: %w(選択してください) }
  validates :price, numericality: [greater_than: 300, less_than: 10000000]

  belongs_to :category
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :quality

end