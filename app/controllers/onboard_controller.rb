# frozen_string_literal: true

class OnboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  after_action :verify_authorized

  def start
  end

  def new_ward
    @unit = Unit.new
  end

  def request_access
  end

  def submit_request
    @unit = Unit.find_by(name: params[:unit_name])

    if @unit.present?
      if @unit.members.where(email: current_user.email).exists?
        ::UnitAccessRequestJob.perform_later(unit: @unit, user: current_user)

        flash[:success] = t("controllers.onboard_controller.request_sent", unit_name: @unit.name)
      else
        flash[:alert] = t("controllers.onboard_controller.email_not_found", email: current_user.email)
      end

      redirect_to root_path
    else
      flash[:alert] = t("controllers.onboard_controller.unit_not_found", unit_name: params[:unit_name])
      redirect_to onboard_request_access_path
    end
  end

  private

  def authorize_user
    authorize ::OnboardController, policy_class: ::OnboardPolicy
  end
end
