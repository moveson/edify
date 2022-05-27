# frozen_string_literal: true

namespace :temp do
  desc "Sets user admin column"
  task set_admin: :environment do
    Rails.application.eager_load!

    User.find_each do |user|
      if user.role == "admin"
        user.update(admin: true, role: :bishopric)
      else
        user.update(admin: false)
      end
    end

    puts "Finished setting roles"
  end
end
