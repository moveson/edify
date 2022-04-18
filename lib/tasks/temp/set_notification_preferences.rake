# frozen_string_literal: true

namespace :temp do
  desc "Sets initial notification preferences for existing users" do
    task :set_notification_preferences => :environment do |_, args|
      Rails.application.eager_load!

      # We just need to invoke callbacks
      User.find_each(&:save!)
    end
  end
end
