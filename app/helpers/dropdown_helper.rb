# frozen_string_literal: true

module DropdownHelper
  def build_dropdown_menu(title, items, options = {})
    container_tag = :div
    container_class = "btn-group"
    content_tag container_tag, class: [container_class, options[:class]].join(" ") do
      toggle_tag = :button
      toggle_class = "btn btn-outline-secondary dropdown-toggle"
      concat content_tag(toggle_tag, class: toggle_class, data: { "bs-toggle" => "dropdown" }) {
        safe_concat title
        safe_concat "&nbsp;"
      }

      concat content_tag(:div, class: "dropdown-menu") {
        items.reject { |item| item[:visible] == false }.each do |item|
          if item[:role] == :separator
            concat content_tag(:div, "", class: "dropdown-divider")
          else
            active = item[:active] ? "active" : nil
            disabled = item[:disabled] ? "disabled" : nil
            html_class = ["dropdown-item", active, disabled, item[:class]].compact.join(" ")
            concat link_to item[:name], item[:link], { class: html_class }.merge(item.slice(:method, :data))
          end
        end
      }
    end
  end

  def filter_members_gender_dropdown(request_params)
    existing_gender_filter = request_params.dig(:q, :gender_eq).presence

    title = case existing_gender_filter
            when nil
              "Combined"
            when "0"
              "Male"
            when "1"
              "Female"
            else
              "Unknown filter"
            end

    dropdown_items = [
      { name: "Combined",
        link: request_params.deep_merge(q: { gender_eq: nil }),
        active: existing_gender_filter == nil },
      { name: "Male",
        link: request_params.deep_merge(q: { gender_eq: "0" }),
        active: existing_gender_filter == "0" },
      { name: "Female",
        link: request_params.deep_merge(q: { gender_eq: "1" }),
        active: existing_gender_filter == "1" },
    ]

    build_dropdown_menu(title, dropdown_items)
  end

  def filter_members_age_dropdown(request_params)
    adult_threshold = 18.years.ago.beginning_of_year.to_date.to_s
    all_ages_filter = { birthdate_gteq: nil, birthdate_lt: nil }
    adult_filter = { birthdate_gteq: nil, birthdate_lt: adult_threshold }
    youth_filter = { birthdate_gteq: adult_threshold, birthdate_lt: nil }

    existing_age_filter = [:birthdate_gteq, :birthdate_lt].map { |attr| [attr, request_params.dig(:q, attr).presence] }.to_h

    title = case existing_age_filter
            when all_ages_filter
              "All ages"
            when adult_filter
              "Adults"
            when youth_filter
              "Youth"
            else
              "Custom ages"
            end

    dropdown_items = [
      { name: "All",
        link: request_params.deep_merge(q: all_ages_filter),
        active: existing_age_filter == all_ages_filter },
      { name: "Adults",
        link: request_params.deep_merge(q: adult_filter),
        active: existing_age_filter == adult_filter },
      { name: "Youth",
        link: request_params.deep_merge(q: youth_filter),
        active: existing_age_filter == youth_filter },
    ]

    build_dropdown_menu(title, dropdown_items)
  end

  def sort_members_dropdown(request_params, ransack_query)
    existing_sort_attribute = ransack_query.sorts.first.name
    title = case existing_sort_attribute
            when "name"
              "By name"
            when "birthdate"
              "By age"
            when "last_talk_date"
              "By last talk"
            else
              "By custom sort"
            end

    dropdown_items = [
      { name: "Name",
        link: request_params.deep_merge(q: { s: "name asc" }),
        active: existing_sort_attribute == "name" },
      { name: "Age",
        link: request_params.deep_merge(q: { s: "birthdate desc" }),
        active: existing_sort_attribute == "birthdate" },
      { name: "Last talk",
        link: request_params.deep_merge(q: { s: "last_talk_date asc" }),
        active: existing_sort_attribute == "last_talk_date" },
    ]

    build_dropdown_menu(title, dropdown_items)
  end

  def sort_talks_dropdown(request_params, ransack_query)
    existing_sort_attribute = ransack_query.sorts.first.name
    title = case existing_sort_attribute
            when "speaker_name"
              "By name"
            when "date"
              "By date"
            else
              "By custom sort"
            end

    dropdown_items = [
      { name: "Date",
        link: request_params.deep_merge(q: { s: "date desc" }),
        active: existing_sort_attribute == "date" },
      { name: "Name",
        link: request_params.deep_merge(q: { s: "speaker_name asc" }),
        active: existing_sort_attribute == "speaker_name" },
    ]

    build_dropdown_menu(title, dropdown_items)
  end
end