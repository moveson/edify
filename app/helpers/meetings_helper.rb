# frozen_string_literal: true

module MeetingsHelper
  def select_options_for_meeting_scheduler(meeting)
    users = current_unit.users.where.not(id: current_user.id).to_a
    users.unshift(current_user)
    select_array = users.map { |user| [user.name, user.id] }
    select_array.push(["Unassigned", ""])
    default_value = meeting.persisted? ? meeting.user_id.to_s : (meeting.user_id || current_user.id).to_s

    options_for_select(select_array, default_value)
  end
end
