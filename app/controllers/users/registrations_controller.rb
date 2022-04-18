# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        respond_with resource, location: after_update_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        redirect_to settings_password_path, notice: resource.errors.full_messages.join("; ")
      end
    end

    protected

    def after_update_path_for(_resource)
      settings_password_path
    end
  end
end
