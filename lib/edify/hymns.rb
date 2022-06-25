# frozen_string_literal: true

require "csv"

module Edify
  class Hymns
    class << self
      attr_reader :database

      def load!
        load_database!
      end

      def load_database!
        @database =
          ::CSV.readlines(::Rails.root.join("lib/edify/db/hymns.txt"), :col_sep => "\t").map do |title, number|
            [number.to_i, title]
          end
      end
    end
  end
end
