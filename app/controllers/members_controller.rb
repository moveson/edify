# frozen_string_literal: true

class MembersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :upsert
  before_action :authenticate_user!
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members
  def index
    @q = Member.with_last_talk_date.ransack(params[:q])
    @q.sorts = ["name asc"] if @q.sorts.empty?
    @members = @q.result
  end

  # GET /members/1
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to members_url, notice: "Member was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      respond_to do |format|
        format.html do
          redirect_to @member, notice: "Member was successfully updated."
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@member, partial: "members/member", locals: { member: @member })
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy

    respond_to do |format|
      format.html do
        redirect_to members_url, notice: "Member was successfully destroyed."
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@member)
      end
    end
  end

  # POST /members/upsert
  # This is an upsert using name and birthdate as a composite unique key
  def upsert
    @member = Member.find_or_initialize_by(name: member_params[:name], birthdate: member_params[:birthdate])
    existing_member = @member.persisted?
    @member.assign_attributes(member_params)

    if @member.save
      respond_to do |format|
        format.json do
          if existing_member
            status = :ok
            synced_at = Time.current
          else
            status = :created
            synced_at = @member.created_at
          end

          @member.update_column(:synced_at, synced_at)
          render json: @member.to_json, status: status
        end
      end
    else
      respond_to do |format|
        format.json { render json: @member.errors.full_messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :gender, :birthdate, :phone, :email)
  end
end
