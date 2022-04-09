# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_one_attached :avatar
  has_person_name
  has_noticed_notifications

  has_many :meetings, foreign_key: :scheduler_id, dependent: :nullify
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :services
  belongs_to :unit, optional: true

  after_create_commit :notify_admins

  scope :admin, -> { where(admin: true) }

  validates :phone, phone: { allow_blank: true }

  strip_attributes

  def assigned_to_unit?
    unit_id?
  end

  def unit_name
    unit.name
  end

  private

  def notify_admins
    ::NewUserAdminNotification.with(user: self).deliver_later(::User.admin.all)
  end
end
