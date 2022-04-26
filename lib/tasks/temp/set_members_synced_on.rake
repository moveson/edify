# frozen_string_literal: true

namespace :temp do
  desc "Sets initial notification preferences for existing users"
  task :set_members_synced_on => :environment do |_, _args|
    Rails.application.eager_load!

    Member.find_each do |member|
      puts "Setting synced_on for #{member.name}"
      synced_on = member.synced_at&.to_date

      unless member.update(synced_on: synced_on)
        puts "Update failed for #{member.name}: #{member.errors.full_messages}"
      end
    end
  end
end
