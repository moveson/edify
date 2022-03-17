class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_one_attached :avatar
  has_person_name
  has_noticed_notifications

  has_many :import_jobs
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :services
end
