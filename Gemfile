source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.3"

gem "rails", "~> 7.2.0"

gem "bootsnap", require: false
gem "pg"
gem "puma"
gem "redis"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

gem "acts_as_list"
gem "american_date"
gem "aws-sdk-s3", require: false
gem "cssbundling-rails"
gem "csv"
gem "devise"
gem "devise-jwt"
gem "font_awesome5_rails"
gem "friendly_id"
gem "image_processing", "~> 1.2"
gem "jsbundling-rails"
gem "madmin", "~> 1.2"
gem "mission_control-jobs"
gem "name_of_person"
gem "nokogiri", ">= 1.13.4"
gem "noticed", "~> 1.0"
gem "pagy"
gem "phonelib"
gem "pretender"
gem "pundit"
gem "ransack"
gem "responders"
gem "rest-client"
gem "sendgrid-ruby"
gem "sentry-ruby"
gem "solid_queue"
gem "strip_attributes"

group :development, :test do
  gem "brakeman"
  gem "bundler-audit"
  gem "rspec-rails"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "ffaker"
  gem "foreman"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
