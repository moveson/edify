# frozen_string_literal: true

class ImportJob < ApplicationRecord
  belongs_to :unit
  has_one_attached :raw_data
  broadcasts_to :unit, inserts_by: :prepend

  scope :most_recent_first, -> { reorder(created_at: :desc) }

  attribute :row_count, default: 0
  attribute :succeeded_count, default: 0
  attribute :failed_count, default: 0
  attribute :ignored_count, default: 0

  enum status: {
    waiting: 0,
    extracting: 1,
    transforming: 2,
    loading: 3,
    finished: 4,
    failed: 5
  }

  alias_attribute :owner_id, :user_id

  def data_string=(string)
    @data_string = string

    raw_data.attach(
      io: StringIO.new(string),
      filename: "raw_data.txt",
      content_type: "text/plain"
    )
  end

  def data_string
    return @data_string if defined?(@data_string)

    @data_string = raw_data.download
  end

  def parsed_errors
    JSON.parse(error_message || "[\"None\"]")
  end

  def set_elapsed_time!
    return unless persisted? && started_at.present?

    update_column(:elapsed_seconds, Time.current - started_at)
  end

  def start!
    update(started_at: ::Time.current)
  end
end
