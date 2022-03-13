# frozen_string_literal: true

module Brigham
  class Credentials
    def initialize(username:, password:)
      @username = username
      @password = password
    end

    def encrypted_username
      crypt.encrypt_and_sign(username)
    end

    def encrypted_password
      crypt.encrypt_and_sign(password)
    end

    def decrypted_username
      crypt.decrypt_and_verify(username)
    end

    def decrypted_password
      crypt.decrypt_and_verify(password)
    end

    private

    attr_reader :username, :password

    def crypt
      @crypt ||= ActiveSupport::MessageEncryptor.new(key)
    end

    def key
      @key ||= Rails.application.secret_key_base.first(32)
    end
  end
end
