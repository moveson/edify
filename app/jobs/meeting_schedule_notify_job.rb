# frozen_string_literal: true

class MeetingScheduleNotifyJob < ::ApplicationJob
  queue_as :default

  def perform(*_args)
    Unit.find_each do |unit|
      ::CheckMeetingsAndNotify.perform!(unit)
    end
  end
end
