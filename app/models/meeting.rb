# frozen_string_literal: true

class Meeting < ApplicationRecord
  has_many :talks
  belongs_to :unit
  belongs_to :scheduler, class_name: "User", optional: true

  enum meeting_type: {
    sacrament_meeting: 0,
    testimony_meeting: 1,
    ward_conference: 2,
    stake_conference: 3,
    general_conference: 4,
    primary_program: 5,
    musical_testimony: 6,
  }

  validates_presence_of :meeting_type, :date
  validates_uniqueness_of :date, scope: :unit

  scope :most_recent_first, -> { order(date: :desc) }

  def self.next_available_sunday(unit)
    future_meeting_dates = unit.meetings.where("date > ?", Date.current).order(:date).pluck(:date).select(&:sunday?)

    proposed_date = Date.current.next_occurring(:sunday)
    while proposed_date.in?(future_meeting_dates) do
      proposed_date += 7.days
    end

    proposed_date
  end

  def status
    case meeting_type.to_sym
    when :sacrament_meeting
      sacrament_status
    when :ward_conference
      sacrament_status
    else
      :ok
    end
  end

  def sacrament_status
    case
    when talk_count == 0
      :empty
    when talk_count < 3
      :incomplete
    else
      :ok
    end
  end

  def talk_count
    @talk_count ||= talks.size
  end
end
