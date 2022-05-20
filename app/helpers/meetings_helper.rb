# frozen_string_literal: true

module MeetingsHelper
  def select_options_for_meeting_scheduler(meeting)
    users = current_unit.users.where.not(id: current_user.id).to_a
    users.unshift(current_user)
    select_array = users.map { |user| [user.name, user.id] }
    select_array.push(["Unassigned", ""])
    default_value = meeting.persisted? ? meeting.scheduler_id.to_s : (meeting.scheduler_id || current_user.id).to_s

    options_for_select(select_array, default_value)
  end

  def select_options_for_user_role
    select_array = User::ASSIGNABLE_ROLES.map { |role| [role.titleize, role] }

    options_for_select(select_array, "")
  end
end
