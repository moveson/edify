# frozen_string_literal: true

module LinkHelper
  def dropdown_sort_link(label, sort_string, request_params, ransack_query)
    existing_sort_attribute = ransack_query.sorts.first.name
    desired_sort_attribute = sort_string.split.first
    active_string = (existing_sort_attribute == desired_sort_attribute) ? "active" : nil
    html_class = ["dropdown-item", active_string].compact.join(" ")
    link_to label, request_params.deep_merge(q: { s: sort_string }), class: html_class
  end

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
end
