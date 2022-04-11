# frozen_string_literal: true

class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  scope :most_recent_first, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }

  def to_notification
    super
  rescue ::ActiveRecord::RecordNotFound
    nil
  end
end
