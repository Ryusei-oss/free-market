class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

        has_many :sns_credentials

         validates :last_name, presence: true
         validates :first_name, presence: true
         validates :last_name_kana, presence: true
         validates :first_name_kana, presence: true
         validates :birthday, presence: true
         validates :nickname, presence: true, uniqueness: true
         validates :tell, presence: true
         validates :content, presence: true

        def self.from_omniauth(auth)
          sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create

          user = sns.user || User.where(email: auth.info.email).first_or_initialize(
            nickname: auth.info.name,
            email: auth.info.email
          )
            if user.persisted?
              sns.user = user
              sns.save
            end
            user
        end
end
