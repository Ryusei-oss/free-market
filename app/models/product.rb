class Product < ApplicationRecord
  validates :name, length: {maximum: 40}, presence: true
  validates :explanation, length: {maximum: 1000}, presence: true
  validates :quality_id, exclusion: {in: %w(選択してください) }, presence: true
  validates :shipping_charge_id, exclusion: {in: %w(選択してください) }, presence: true
  validates :area_id, exclusion: {in: %w(選択してください) }, presence: true
  validates :delivery_date_id,  exclusion: {in: %w(選択してください) }, presence: true
  validates :price, numericality: [greater_than: 300, less_than: 10000000], presence: true

  belongs_to :category
  belongs_to :user
  has_many :images
  has_many :likes
  has_many :addresses
  accepts_nested_attributes_for :images, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :quality
  belongs_to_active_hash :delivery_date

end