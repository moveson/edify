# frozen_string_literal: true

class EdifyConfig
  def self.sendgrid_api_key
    ::ENV["SENDGRID_API_KEY"]
  end
end
