# frozen_string_literal: true

module MeetingsHelper
  def badge_for_meeting_type(meeting_type)
    text = meeting_badge_attributes.dig(meeting_type, :text)
    color = meeting_badge_attributes.dig(meeting_type, :color)

    content_tag(
      :span,
      text,
      class: ["badge", "bg-#{color}"].join(" "),
      data: { "bs-toggle" => "tooltip" },
      title: meeting_type.titleize
    )
  end

  def meeting_badge_attributes
    {
      sacrament_meeting: { text: "SM", color: "success" },
      testimony_meeting: { text: "TM", color: "secondary" },
      ward_conference: { text: "WC", color: "success" },
      stake_conference: { text: "SC", color: "info" },
      general_conference: { text: "GC", color: "primary" },
      primary_program: { text: "PP", color: "info" },
      musical_testimony: { text: "MT", color: "secondary" }
    }.with_indifferent_access.freeze
  end

  def select_options_for_meeting_scheduler(meeting)
    users = current_unit.users.where.not(id: current_user.id).to_a
    users.unshift(current_user)
    select_array = users.map { |user| [user.name, user.id] }
    select_array.push(["Unassigned", ""])
    bishopric_user_id = current_user.bishopric? ? current_user.id : nil
    new_meeting_default = (meeting.scheduler_id || bishopric_user_id).to_s
    default_value = meeting.persisted? ? meeting.scheduler_id.to_s : new_meeting_default

    options_for_select(select_array, default_value)
  end
end
