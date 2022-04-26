# frozen_string_literal: true

module MembersHelper
  def link_to_pause(member, period)
    number, unit = period.split
    paused_until = number.to_i.send(unit).from_now.to_date

    link_to period,
            member_path(member,
                        member: {
                          paused_until: paused_until,
                          paused_on: Date.current,
                          paused_by: current_user.id
                        }),
            method: :patch,
            class: "btn btn-outline-primary"
  end
end
