# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def svg_icon(path, name, options = {})
    width = options[:width].present? ? options[:width] : '16'
    height = options[:height].present? ? options[:height] : '16'
    css_class = options[:class].present? ? options[:class] : 'black'

    tag = "<svg width=\"#{width}px\" height=\"#{height}px\" viewBox=\"0 0 #{width} #{height}\" class=\"icon #{css_class}\">" +
      "<use xlink:href=\"#{ asset_path path }##{name}\"></use>" +
      "</svg>"

    tag.html_safe
  end

  def form_actions(inline: false, plain: false, centered: false, &block)
    css_class = %w(form_actions)
    css_class << 'inline' if inline
    css_class << 'plain' if plain
    css_class << 'centered' if centered
    css_class = css_class.join(' ')
    actions = content_tag(:div, capture(&block), class: 'inner')
    content_tag(:div, actions, class: css_class)
  end

  def record_form_for(record, options = {}, &block)
    options.merge! builder: RecordFormBuilder
    options[:html] = options[:html] || {}
    options[:html].merge! autocomplete: 'off'
    options[:html].merge! class: 'record_form'
    form_for record, options, &block
  end
end
