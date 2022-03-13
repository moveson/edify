# frozen_string_literal: true

class ImportJob < ApplicationRecord
  belongs_to :user
  broadcasts_to :user, inserts_by: :prepend

  scope :most_recent_first, -> { reorder(created_at: :desc) }
  scope :owned_by, ->(user) { where(user: user) }

  attribute :row_count, default: 0
  attribute :success_count, default: 0
  attribute :failure_count, default: 0

  enum status: {
    waiting: 0,
    extracting: 1,
    transforming: 2,
    loading: 3,
    finished: 4,
    failed: 5
  }

  alias_attribute :owner_id, :user_id

  def parsed_errors
    JSON.parse(error_message || "[\"None\"]")
  end

  def set_elapsed_time!
    return unless persisted? && started_at.present?

    update_column(:elapsed_time, Time.current - started_at)
  end

  def start!
    update(started_at: ::Time.current)
  end
end
