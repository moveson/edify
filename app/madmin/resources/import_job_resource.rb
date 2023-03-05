# frozen_string_literal: true

class ImportJobResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :status
  attribute :status_text
  attribute :row_count, form: false
  attribute :succeeded_count, form: false
  attribute :failed_count, form: false
  attribute :ignored_count, form: false
  attribute :started_at
  attribute :elapsed_seconds
  attribute :error_message
  attribute :logs, index: false
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :raw_data, index: false

  # Associations
  attribute :unit

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
