class MeetingResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :meeting_type
  attribute :date
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
  attribute :scheduler
  attribute :talks
  attribute :unit

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  def self.default_sort_column
    "date"
  end

  def self.default_sort_direction
    "desc"
  end
end
