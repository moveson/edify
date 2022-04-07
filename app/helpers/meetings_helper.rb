# frozen_string_literal: true

module MeetingsHelper
  def select_options_for_meeting_scheduler(meeting)
    users = current_unit.users.where.not(id: current_user.id).to_a
    users.unshift(current_user)
    select_array = users.map { |user| [user.name, user.id] }
    select_array.push(["Unassigned", nil])
    default_value = meeting.persisted? ? meeting.user_id : meeting.user_id || current_user.id

    options_for_select(select_array, default_value)
  end
end
