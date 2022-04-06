# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  impersonates :user

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :turbo_frame_request_variant

  helper_method :current_unit
  helper_method :user_assigned_to_unit?

  def current_unit
    @current_unit ||= current_user.unit
  end

  def user_assigned_to_unit?
    @user_assigned_to_unit ||= current_unit.present?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :avatar])
  end

  private

  def authorize_user
    authorize controller_name.classify.constantize
  end

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
