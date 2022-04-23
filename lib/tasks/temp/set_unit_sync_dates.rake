# frozen_string_literal: true

namespace :temp do
  desc "Sets initial notification preferences for existing users"
  task :set_unit_sync_dates => :environment do |_, _args|
    Rails.application.eager_load!

    Unit.find_each do |unit|
      puts "Setting sync attributes for unit #{unit.name}"
      first_sync = unit.members.minimum(:created_at)
      last_sync = unit.members.maximum(:synced_at)

      unless unit.update(first_synced_on: first_sync, last_synced_on: last_sync)
        puts "Sync failed for #{unit.name}: #{unit.errors.full_messages}"
      end
    end
  end
end
