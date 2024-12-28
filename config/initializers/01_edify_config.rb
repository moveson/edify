# frozen_string_literal: true

class EdifyConfig
  def self.app_url
    ::ENV["APP_URL"] || "localhost:3000"
  end

  def self.cloudflare_turnstile_secret_key
    Rails.application.credentials.dig(:cloudflare, :turnstile, :secret_key)
  end

  def self.cloudflare_turnstile_site_key
    Rails.application.credentials.dig(:cloudflare, :turnstile, :site_key)
  end

  def self.cloudflare_turnstile_site_verify_url
    "https://challenges.cloudflare.com/turnstile/v0/siteverify"
  end

  def self.cloudflare_turnstile_js_url
    "https://challenges.cloudflare.com/turnstile/v0/api.js"
  end

  def self.email_sender_address
    "no-reply@#{app_url}"
  end

  def self.sendgrid_api_key
    Rails.application.credentials.dig(:sendgrid, :api_key)
  end

  def self.sendgrid_webhook_verification_key
    Rails.application.credentials.dig(:sendgrid, :webhook_verification_key)
  end

  def self.sentry_dsn
    Rails.application.credentials.dig(:sentry, :dsn)
  end
end
