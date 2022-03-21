# frozen_string_literal: true

class TalksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :upsert
  before_action :authenticate_user!
  before_action :set_talk, only: %i[ show edit update destroy ]

  # GET /talks
  def index
    @q = Talk.ransack(params[:q])
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
      redirect_to @talk, notice: "Talk was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /talks/1
  def update
    if @talk.update(talk_params)
      redirect_to @talk, notice: "Talk was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /talks/1
  def destroy
    @talk.destroy
    redirect_to talks_url, notice: "Talk was successfully destroyed."
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
        format.json { render @talk.errors.full_messages.to_json, status: :unprocessable_entity }
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
