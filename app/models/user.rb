class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, length: { minimum: 7}
  validates :last_name, :first_name, :last_name_kana,:first_name_kana,
            :birthday, :nickname, :tell, presence: true

  has_many :products
  has_many :addresses
end
