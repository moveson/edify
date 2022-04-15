# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController

    protected

    def after_update_path_for(_resource)
      settings_password_path
    end
  end
end
