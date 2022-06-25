class Song < ApplicationRecord
  belongs_to :meeting

  enum song_type: {
    opening_hymn: 0,
    sacrament_hymn: 1,
    congregational_hymn: 2,
    musical_number: 3,
    closing_hymn: 4,
  }

  scope :default_order, -> { order(:song_type) }
end
