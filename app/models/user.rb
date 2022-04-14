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

  has_many :scheduled_meetings, class_name: "Meeting", foreign_key: :scheduler_id, dependent: :nullify
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :services, dependent: nil
  has_one :access_request, dependent: :destroy
  belongs_to :unit, optional: true

  after_commit :send_welcome_notifications

  scope :admin, -> { where(admin: true) }

  validates :phone_number, phone: { allow_blank: true }

  strip_attributes

  def assigned_to_unit?
    unit_id?
  end

  def needs_onboarding?
    unit_id.nil? && access_request.nil?
  end

  def pending_unit
    access_request&.unit
  end

  def unit_name
    unit&.name
  end

  private

  def send_welcome_notifications
    return true unless newly_confirmed?

    ::NewUserAdminNotification.with(user: self).deliver_later(::User.admin.all)
    ::NewUserNotification.with(user: self).deliver_later(self)
  end

  def newly_confirmed?
    saved_changes["confirmed_at"].present? && saved_changes["confirmed_at"].first.nil?
  end
end
