source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "redis", "~> 4.0"
gem "bootsnap", require: false

gem "american_date"
gem "cssbundling-rails"
gem "devise", "~> 4.8", ">= 4.8.0"
gem "devise-jwt"
gem "font_awesome5_rails"
gem "friendly_id", "~> 5.4"
gem "jsbundling-rails"
gem "madmin"
gem "name_of_person", "~> 1.1"
gem "noticed", "~> 1.4"
gem "pretender", "~> 0.3.4"
gem "pundit", "~> 2.1"
gem "ransack"
gem "responders"
gem "sassc-rails"
gem "sidekiq", "~> 6.2"
gem "strip_attributes"
gem "whenever", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "dotenv-rails"
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
