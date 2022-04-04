# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  impersonates :user

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :turbo_frame_request_variant

  helper_method :current_unit

  def current_unit
    @current_unit ||= current_user.unit
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
