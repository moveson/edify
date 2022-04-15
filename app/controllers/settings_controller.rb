# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_action
  after_action :verify_authorized

  # GET /preferences
  def preferences
  end

  # GET /avatar
  def avatar
  end

  # GET /password
  def password
  end

  def update
    if current_user.update(settings_update_params)
      message = "Updated."
    else
      message = current_user.errors.full_messages.join("; ")
    end

    redirect_to request.referrer, notice: message
  end

  def remove_avatar
    current_user.avatar.purge if current_user.avatar.attached?

    redirect_to settings_avatar_path
  end

  private

  def authorize_action
    authorize self, policy_class: ::SettingsPolicy
  end

  def settings_update_params
    params.require(:user).permit(:avatar, :email, :name, :phone_number)
  end
end
