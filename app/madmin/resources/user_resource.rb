class UserResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :email
  attribute :first_name
  attribute :last_name
  attribute :phone
  attribute :confirmed_at
  attribute :admin
  attribute :reset_password_sent_at
  attribute :remember_created_at
  attribute :announcements_last_read_at
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :avatar, index: false

  # Associations
  attribute :notifications
  attribute :services
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
