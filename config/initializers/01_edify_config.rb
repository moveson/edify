# frozen_string_literal: true

class EdifyConfig
  def self.app_url
    ::ENV["APP_URL"] || "localhost:3000"
  end

  def self.sentry_dsn
    Rails.application.credentials.dig(:sentry, :dsn)
  end
end
