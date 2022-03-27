# frozen_string_literal: true

class TalksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :upsert
  before_action :authenticate_user!
  before_action :set_talk, only: %i[ show edit update destroy ]

  # GET /talks
  def index
    @q = Talk.ransack(params[:q])
    @q.sorts = ["date desc", "speaker_name asc"] if @q.sorts.empty?
    @talks = @q.result.includes(:member)
  end

  # GET /talks/1
  def show
  end

  # GET /talks/new
  def new
    @talk = Talk.new
  end

  # GET /talks/1/edit
  def edit
  end

  # POST /talks
  def create
    @talk = Talk.new(talk_params)

    if @talk.save
      respond_to do |format|
        format.html do
          redirect_to @talk, notice: "Talk was successfully created."
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(:talks, partial: "talks/talk", locals: { talk: @talk })
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /talks/1
  def update
    if @talk.update(talk_params)
      respond_to do |format|
        format.html do
          redirect_to @talk, notice: "Talk was successfully updated."
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@talk, partial: "talks/talk", locals: { talk: @talk })
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /talks/1
  def destroy
    @talk.destroy

    respond_to do |format|
      format.html do
        redirect_to talks_url, notice: "Talk was successfully destroyed."
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@talk)
      end
    end
  end

  # POST /talks/upsert
  # This is an upsert using speaker_name and date as a composite unique key
  def upsert
    @talk = Talk.find_or_initialize_by(speaker_name: talk_params[:speaker_name], date: talk_params[:date])
    existing_talk = @talk.persisted?
    @talk.assign_attributes(talk_params)

    if @talk.save
      respond_to do |format|
        format.json do
          status = existing_talk ? :ok : :created
          render json: @talk.to_json, status: status
        end
      end
    else
      respond_to do |format|
        format.json { render json: @talk.errors.full_messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_talk
    @talk = Talk.find(params[:id])
  end

  def talk_params
    params.require(:talk).permit(:member_id, :speaker_name, :date, :purpose, :topic)
  end
end
