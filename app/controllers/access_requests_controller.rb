# frozen_string_literal: true

class AccessRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :set_access_request, only: %i[update destroy]
  after_action :verify_authorized

  # GET /access_requests
  def index
    @access_requests = current_unit.access_requests
  end

  # GET /access_requests/new
  def new
    @access_request = ::AccessRequest.new
  end

  # POST /access_requests
  def create
    unit_name_param = access_request_params[:unit_name]
    @unit = Unit.find_by(name: unit_name_param)

    if @unit.present?
      if @unit.members.where(email: current_user.email).exists?
        @unit.access_requests.create(user: current_user)
        ::UnitAccessRequestJob.perform_later(unit: @unit, user: current_user)

        flash[:success] = t("controllers.access_request_controller.request_sent", unit_name: @unit.name)
        redirect_to root_path
      else
        flash[:alert] = t("controllers.access_request_controller.email_not_found", email: current_user.email, unit_name: @unit.name)
        redirect_to new_access_request_path
      end
    else
      flash[:alert] = t("controllers.access_request_controller.unit_not_found", unit_name: unit_name_param)
      redirect_to new_access_request_path
    end
  end

  # PATCH/PUT /access_requests/1
  def update
    if @access_request.update(access_request_params)
      redirect_to @access_request, notice: "Access request was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /access_requests/1
  def destroy
    @access_request.destroy
    redirect_to access_requests_url, notice: "Access request was successfully destroyed."
  end

  private

  def set_access_request
    @access_request = AccessRequest.find(params[:id])
  end

  def access_request_params
    params.require(:access_request).permit(:unit_name, :approved)
  end
end
