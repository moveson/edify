# frozen_string_literal: true

require "utilities/brigham"

class ImportJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_import_job, only: [:show, :destroy]

  # GET /import_jobs
  def index
    @import_jobs = current_user.import_jobs
  end

  # GET /import_jobs/:id
  def show
  end

  # GET /import_jobs/new
  def new
    @import_job = current_user.import_jobs.new
  end

  # POST /import_jobs
  def create
    @import_job = current_user.import_jobs.new
    @import_job.status = :waiting

    username = params[:username]
    password = params[:password]

    if username.present? && password.present?
      credentials = ::Brigham::Credentials.new(username: username, password: password)

      if @import_job.save
        ::Brigham::FetchMembersJob.perform_later(
          username: credentials.encrypted_username,
          password: credentials.encrypted_password,
          import_job_id: @import_job.id
        )

        redirect_to import_jobs_url, notice: "Import in progress"
      else
        flash[:danger] = "Unable to create import job: #{@import_job.errors.full_messages.join(', ')}"
        render "new"
      end
    else
      flash[:danger] = "Username and password must be provided"
      render :new
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

  def set_import_job
    @import_job = ::ImportJob.find(params[:id])
  end

  def set_user
    @user = if current_user.admin?
              params[:user_id].present? ? ::User.find_by(id: params[:user_id]) : current_user
            else
              current_user
            end
  end
end
