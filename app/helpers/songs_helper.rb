# frozen_string_literal: true

module SongsHelper
  def hymns_datalist
    ::Edify::Hymns.database.map do |number, title|
      concat content_tag(:option, nil, value: "#{title} ##{number}")
    end
  end
end
