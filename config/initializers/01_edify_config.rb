# frozen_string_literal: true

class EdifyConfig
  def self.sendgrid_api_key
    Rails.application.credentials.sendgrid[:api_key]
  end
end
