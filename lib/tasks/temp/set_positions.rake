# frozen_string_literal: true

namespace :temp do
  desc "Sets user roles"
  task set_positions: :environment do
    Rails.application.eager_load!

    Meeting.find_each do |meeting|
      puts "Setting positions for talks in meeting for #{I18n.l(meeting.date, format: :rfc822)}"
      meeting.talks.order(:updated_at).each.with_index(1) do |talk, index|
        talk.update_column(:position, index)
      end
    end

    puts "Finished setting positions"
  end
end
