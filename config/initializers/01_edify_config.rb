# frozen_string_literal: true

class EdifyConfig
  def self.app_url
    ::ENV["APP_URL"] || "localhost:3000"
  end

  def self.email_sender_address
    "no-reply@#{app_url}"
  end

  def self.sendgrid_api_key
    Rails.application.credentials.dig(:sendgrid, :api_key)
  end

  def self.sentry_dsn
    Rails.application.credentials.dig(:sentry, :dsn)
  end
end
