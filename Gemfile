source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "sprockets-rails"
gem "pg"
gem "puma"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "redis"
gem "bootsnap", require: false

gem "american_date"
gem "cssbundling-rails"
gem "devise"
gem "devise-jwt"
gem "font_awesome5_rails"
gem "friendly_id"
gem "jsbundling-rails"
gem "madmin"
gem "name_of_person"
gem "noticed"
gem "pagy"
gem "phonelib"
gem "pretender"
gem "pundit"
gem "ransack"
gem "responders"
gem "sassc-rails"
gem "sendgrid-ruby"
gem "sidekiq"
gem "sidekiq-cron"
gem "strip_attributes"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "web-console"
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "webdrivers"
  gem "selenium-webdriver"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
