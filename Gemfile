# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.2", ">= 7.0.2.3"

gem "bootsnap", require: false
gem "importmap-rails"
gem "pg"
gem "puma"
gem "redis"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

gem "american_date"
gem "aws-sdk-s3", require: false
gem "cssbundling-rails"
gem "devise"
gem "devise-jwt"
gem "font_awesome5_rails"
gem "friendly_id"
gem "image_processing", "~> 1.2"
gem "jsbundling-rails"
gem "madmin"
gem "name_of_person"
gem "nokogiri", ">= 1.13.4"
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
  gem "brakeman"
  gem "bundler-audit"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "foreman"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "rspec-rails"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
