# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :meeting
  has_one :unit, through: :meeting

  enum song_type: {
    opening_hymn: 0,
    sacrament_hymn: 1,
    congregational_hymn: 2,
    musical_number: 3,
    closing_hymn: 4,
  }

  validates :song_type, :title, presence: true

  scope :default_order, -> { order(:song_type) }

  # @return [ActiveSupport::Duration, nil]
  def duration_since_previously_sung
    previous_song = unit.song_last_sung(title, meeting_date)

    (meeting_date - previous_song.meeting_date).to_i.days if previous_song.present?
  end

  def meeting_date
    meeting.date
  end
end
