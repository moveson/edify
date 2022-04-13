# frozen_string_literal: true

class AccessRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_access_request, only: %i[approve reject destroy]
  before_action :authorize_access_request, only: %i[approve reject destroy]
  before_action :authorize_action, except: %i[approve reject destroy]
  after_action :verify_authorized

  # GET /access_requests/new
  def new
    @access_request = ::AccessRequest.new
  end

  # POST /access_requests
  def create
    unit_name_param = access_request_params[:unit_name]
    @unit = Unit.find_by(name: unit_name_param)

    if @unit.present?
      if @unit.members.exists?(email: current_user.email)
        @unit.access_requests.create(user: current_user)
        ::UnitAccessRequestJob.perform_later(unit: @unit, user: current_user)

        flash[:success] = t("controllers.access_request_controller.request_sent", unit_name: @unit.name)
        redirect_to root_path
      else
        flash[:alert] =
          t("controllers.access_request_controller.email_not_found", email: current_user.email, unit_name: @unit.name)
        redirect_to new_access_request_path
      end
    else
      flash[:alert] = t("controllers.access_request_controller.unit_not_found", unit_name: unit_name_param)
      redirect_to new_access_request_path
    end
  end

  # PATCH/PUT /access_requests/1/approve
  def approve
    user_params = { approved_at: Time.current, approved_by: current_user.id, unit_id: @access_request.unit_id }
    user = @access_request.user

    if user.update(user_params)
      ::UnitAccessApprovalJob.perform_later(unit: @access_request.unit, user: @access_request.user)
      redirect_to access_requests_path, notice: t("controllers.access_request_controller.approve_success")
    else
      redirect_to access_requests_path,
                  notice: t("controllers.access_request_controller.approve_failure"),
                  status: :unprocessable_entity
    end
  end

  # PATCH/PUT /access_requests/1/reject
  def reject
    params = { rejected_at: Time.current, rejected_by: current_user.id }

    if @access_request.update(params)
      ::UnitAccessRejectionJob.perform_later(unit: @access_request.unit, user: @access_request.user)
      redirect_to access_requests_path, notice: t("controllers.access_request_controller.reject_success")
    else
      redirect_to access_requests_path,
                  notice: t("controllers.access_request_controller.reject_failure"),
                  status: :unprocessable_entity
    end
  end

  # DELETE /access_requests/1
  def destroy
    @access_request.destroy
    redirect_to access_requests_path, notice: t("controllers.access_request_controller.destroy_success")
  end

  private

  def authorize_access_request
    authorize @access_request
  end

  def authorize_action
    authorize ::AccessRequest
  end

  def set_access_request
    @access_request = AccessRequest.find(params[:id])
  end

  def access_request_params
    params.require(:access_request).permit(:unit_name)
  end
end