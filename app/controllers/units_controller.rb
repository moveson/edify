# frozen_string_literal: true

class UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :set_unit, only: [:edit, :update]
  after_action :verify_authorized

  # GET /units/new
  def new
    @unit = ::Unit.new
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  def create
    @unit = ::Unit.new(unit_params)
    current_user.role = :bishopric
    @unit.users << current_user

    if @unit.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /units/1
  def update
    if @unit.update(unit_params)
      respond_to do |format|
        format.html do
          redirect_to @unit, notice: t("controllers.units_controller.updated")
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:name)
  end

  def set_unit
    @unit = ::Unit.find(params[:id])
  end
end
