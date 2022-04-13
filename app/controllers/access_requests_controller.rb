# frozen_string_literal: true

class AccessRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_access_request, only: %i[update approve reject destroy]
  before_action :authorize_access_request, only: %i[update approve reject destroy]
  before_action :authorize_action, except: %i[update approve reject destroy]
  after_action :verify_authorized

  # GET /access_requests
  def index
    @access_requests = current_unit.access_requests
    @q = current_unit.access_requests.ransack(params[:q])
    @q.sorts = ["date desc"] if @q.sorts.empty?
    @pagy, @access_requests = pagy(@q.result)
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

  # PATCH/PUT /access_requests/1/approve
  def approve
    user_params = { approved_at: Time.current, approved_by: current_user.id, unit_id: @access_request.unit_id }
    user = @access_request.user

    if user.update(user_params)
      @access_request.destroy
      redirect_to access_requests_path, notice: "Access request was approved."
    else
      redirect_to access_requests_path,
                  notice: "Access request could not be approved. Something went wrong.",
                  status: :unprocessable_entity
    end
  end

  # PATCH/PUT /access_requests/1/reject
  def reject
    params = { rejected_at: Time.current, rejected_by: current_user.id }

    if @access_request.update(params)
      redirect_to access_requests_path, notice: "Access request was rejected."
    else
      redirect_to access_requests_path,
                  notice: "Access request could not be rejected. Something went wrong.",
                  status: :unprocessable_entity
    end
  end

  # DELETE /access_requests/1
  def destroy
    @access_request.destroy
    redirect_to access_requests_path, notice: "Access request was successfully destroyed."
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
