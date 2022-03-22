# frozen_string_literal: true

module LinkHelper
  def dropdown_sort_link(label, sort_string, request_params, ransack_query)
    existing_sort_attribute = ransack_query.sorts.first.name
    desired_sort_attribute = sort_string.split.first
    active_string = (existing_sort_attribute == desired_sort_attribute) ? "active" : nil
    html_class = ["dropdown-item", active_string].compact.join(" ")
    link_to label, request_params.deep_merge(q: { s: sort_string }), class: html_class
  end
end
