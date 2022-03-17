# frozen_string_literal: true

class TalksController < ApplicationController
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

  private

  def set_talk
    @talk = Talk.find(params[:id])
  end

  def talk_params
    params.require(:talk).permit(:member_id, :date, :purpose, :topic)
  end
end
