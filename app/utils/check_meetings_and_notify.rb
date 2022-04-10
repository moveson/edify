# frozen_string_literal: true

class CheckMeetingsAndNotify
  def self.perform!(unit)
    new(unit).perform!
  end

  def initialize(unit)
    @unit = unit
    @today = Date.today
  end

  def perform!
    notify_missing_dates
    notify_incomplete_meetings
  end

  private

  attr_reader :unit, :today

  def notify_missing_dates
    ::MissingMeetingsNotification.with(notifiable_missing_dates).deliver_later(unit.users)
  end

  def notify_incomplete_meetings
    notifiable_incomplete_meetings.group_by(&:scheduler).each do |scheduler, meetings|
      users_to_notify = scheduler || unit.users
      ::IncompleteMeetingsNotification.with(meetings).deliver_later(users_to_notify)
    end
  end

  def notifiable_missing_dates
    if today.saturday?
      missing_meeting_dates
    else
      missing_meeting_dates.select { |date| date == next_sunday }
    end
  end

  def notifiable_incomplete_meetings
    if today.saturday?
      incomplete_meetings
    else
      incomplete_meetings.select { |meeting| meeting.date == next_sunday }
    end
  end

  def missing_meeting_dates
    expected_meeting_dates - existing_meetings.map(&:date)
  end

  def incomplete_meetings
    existing_meetings.select(&:not_fully_scheduled?)
  end

  def existing_meetings
    @existing_meetings ||= unit.meetings.occurring_after(today).to_a
  end

  def expected_meeting_dates
    [
      next_sunday,
      next_sunday + 7.days,
      next_sunday + 14.days,
      next_sunday + 21.days,
    ]
  end

  def next_sunday
    @next_sunday ||= today.next_occurring(:sunday)
  end
end
