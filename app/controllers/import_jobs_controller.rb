# frozen_string_literal: true

class ImportJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_import_job, only: [:show, :destroy]

  # GET /import_jobs
  def index
    @import_jobs = current_unit.import_jobs
  end

  # GET /import_jobs/:id
  def show
  end

  # GET /import_jobs/new
  def new
    @import_job = current_unit.import_jobs.new
  end

  # POST /import_jobs
  def create
    @import_job = current_unit.import_jobs.new(import_job_params)
    @import_job.status = :waiting

    if @import_job.save
      ::ImporterJob.perform_later(current_unit, raw_data)
      redirect_to import_jobs_path, notice: "Import in progress"
    else
      flash[:danger] = "Unable to create import job: #{@import_job.errors.full_messages.join(', ')}"
      render "new"
    end
  end

  # DELETE /import_jobs/:id
  def destroy
    unless @import_job.destroy
      flash[:danger] = "Unable to delete import job: #{@import_job.errors.full_messages.join(', ')}"
    end

    redirect_to import_jobs_path(user_id: @user.id)
  end

  private

  def import_job_params
    params.require(:import_job).permit(:raw_data)
  end

  def set_import_job
    @import_job = ::ImportJob.find(params[:id])
  end
end
