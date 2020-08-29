class Address < ApplicationRecord
  belongs_to :user
  validates :postal_code, presence: true
  validates :area, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
end
