# frozen_string_literal: true

class MeetingsViewObject
  def initialize(meetings, view_context, pagy)
    @meetings = meetings
    @current_user = view_context.current_user
    @pagy = pagy
  end

  attr_reader :meetings, :pagy

  delegate :unit_name, to: :current_user

  # @return [Integer]
  def current_meeting_id
    # We have to use current_unit.meetings here because meetings is scoped to the current pagy
    @current_meeting_id ||= current_unit.meetings.occurring_on_or_after(Date.current).oldest_first.pick(:id)
  end

  # @return [Integer]
  def filtered_count
    pagy.count
  end

  # @return [Integer]
  def total_count
    current_unit.meeting_count
  end

  private

  attr_reader :current_user

  def current_unit
    current_user.unit
  end
end
