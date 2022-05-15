# frozen_string_literal: true

namespace :temp do
  desc "Sets user roles"
  task set_roles: :environment do
    Rails.application.eager_load!

    User.find_each do |user|

      if user.admin
        user.update(role: :admin)
      else
        user.update(role: :bishopric)
      end
    end

    puts "Finished setting roles"
  end
end
