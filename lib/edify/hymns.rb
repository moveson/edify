# frozen_string_literal: true

require "csv"

module Edify
  class Hymns
    class << self
      attr_reader :database, :datalist

      def load!
        load_database!
        create_datalist!
      end

      def load_database!
        array = ::CSV.readlines(::Rails.root.join("lib/edify/db/hymns.txt"), :col_sep => "\t").map do |title, number|
          [number.to_i, title]
        end

        @database = array.sort
      end

      def create_datalist!
        options_array = database.map do |number, title|
          ::ActionController::Base.helpers.content_tag(:option, nil, value: "#{title} ##{number}")
        end

        @datalist = options_array.join("\n").html_safe
      end
    end
  end
end
