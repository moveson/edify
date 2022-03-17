class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members
  def index
    @q = Member.with_last_talk_date.ransack(params[:q])
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
    @member = Member.find_or_initialize_by(name: member_params[:name], birthdate: member_params[:birthdate])
    existing_member = @member.persisted?
    @member.assign_attributes(member_params)

    if @member.save
      respond_to do |format|
        format.html { redirect_to @member, notice: "Member was successfully created." }
        format.json do
          status = existing_member ? :ok : :created
          render json: @member.to_json, status: status
        end
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render @member.errors.full_messages.to_json, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      redirect_to @member, notice: "Member was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to members_url, notice: "Member was successfully destroyed."
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :gender, :birthdate, :phone, :email)
  end
end
