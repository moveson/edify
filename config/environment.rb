# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "apikey", # This is the string literal 'apikey', NOT the ID of your API key
  :password => EdifyConfig.sendgrid_api_key,
  :domain => "edifyapp.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
