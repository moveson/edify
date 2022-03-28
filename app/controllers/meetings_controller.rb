# frozen_string_literal: true

class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: %i[ show edit update destroy ]

  # GET /meetings
  def index
    @q = Meeting.ransack(params[:q])
    @q.sorts = ["date desc"] if @q.sorts.empty?
    @pagy, @meetings = pagy(@q.result)
  end

  # GET /meetings/1
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  def create
    @meeting = Meeting.new(meeting_params)

    if @meeting.save
      respond_to do |format|
        format.html do
          redirect_to meetings_path, notice: "Meeting was successfully created."
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(:meetings, partial: "meetings/meeting", locals: { meeting: @meeting })
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meetings/1
  def update
    if @meeting.update(meeting_params)
      respond_to do |format|
        format.html do
          redirect_to @meeting, notice: "Meeting was successfully updated."
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@meeting, partial: "meetings/meeting", locals: { meeting: @meeting })
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /meetings/1
  def destroy
    @meeting.destroy

    respond_to do |format|
      format.html do
        redirect_to member_url(@member)
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@meeting)
      end
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:date, :meeting_type)
  end
end
