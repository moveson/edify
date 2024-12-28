# frozen_string_literal: true

module Cloudflare
  class TurnstileVerifier
    # @param [String] token
    # @return [Boolean]
    def self.token_valid?(token)
      http_client = ::RestClient
      params = {
        response: token,
        secret: ::EdifyConfig.cloudflare_turnstile_secret_key,
      }

      response = http_client.post(::EdifyConfig.cloudflare_turnstile_site_verify_url, params)
      parsed_response = JSON.parse(response.body)
      parsed_response["success"] == true
    end
  end
end
