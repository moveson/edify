class Song < ApplicationRecord
  belongs_to :meeting

  enum song_type: {
    opening_hymn: 0,
    sacrament_hymn: 1,
    closing_hymn: 2,
    congregational_hymn: 3,
    musical_number: 4,
  }
end
