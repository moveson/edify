# frozen_string_literal: true

module LinkHelper
  def link_to_member_delete(member, options = {})
    html_class = options[:class]
    url = member_path(member)
    tooltip = "Delete this member"
    options = { method: :delete,
                data: { confirm: "This will delete the member and cannot be undone. Are you sure you want to proceed?",
                        turbo: false,
                        toggle: :tooltip,
                        placement: :bottom,
                        "original-title" => tooltip },
                class: ["btn btn-danger btn-sm has-tooltip", html_class].compact.join(" ") }
    link_to fa_icon("trash"), url, options
  end

  def link_to_member_edit(member, options = {})
    html_class = options[:class]
    url = edit_member_path(member)
    tooltip = "Edit this member"
    options = { data: { toggle: :tooltip,
                        placement: :bottom,
                        "original-title" => tooltip },
                class: ["btn btn-primary btn-sm has-tooltip", html_class].compact.join(" ") }
    link_to fa_icon("pencil-alt"), url, options
  end

  def link_to_talk_delete(talk, options = {})
    html_class = options[:class]
    url = talk_path(talk)
    tooltip = "Delete this talk"
    options = { method: :delete,
                data: { confirm: "This will delete the talk and cannot be undone. Are you sure you want to proceed?",
                        turbo: false,
                        toggle: :tooltip,
                        placement: :bottom,
                        "original-title" => tooltip },
                class: ["btn btn-danger btn-sm has-tooltip", html_class].compact.join(" ") }
    link_to fa_icon("trash"), url, options
  end

  def link_to_talk_edit(talk, options = {})
    html_class = options[:class]
    url = edit_talk_path(talk)
    tooltip = "Edit this talk"
    options = { data: { toggle: :tooltip,
                        placement: :bottom,
                        "original-title" => tooltip },
                class: ["btn btn-primary btn-sm has-tooltip", html_class].compact.join(" ") }
    link_to fa_icon("pencil-alt"), url, options
  end
end
