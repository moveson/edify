# frozen_string_literal: true

class AccessRequestResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :approved_by
  attribute :approved_at
  attribute :approved_role
  attribute :rejected_by
  attribute :rejected_at

  # Associations
  attribute :unit
  attribute :user

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
