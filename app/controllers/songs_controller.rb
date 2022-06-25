# frozen_string_literal: true

class SongsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :set_meeting, except: :index
  before_action :set_song, only: %i[show edit update destroy move]
  after_action :verify_authorized

  # GET /meetings/1/songs/1
  def show
  end

  # GET /meetings/1/songs/new
  def new
    @song = @meeting.songs.new
  end

  # GET /meetings/1/songs/1/edit
  def edit
  end

  # POST /meetings/1/songs
  def create
    @song = @meeting.songs.new(song_params)

    if @song.save
      respond_to do |format|
        format.html do
          redirect_to @song, notice: t("controllers.songs_controller.created")
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("meeting_#{@meeting.id}", partial: "meetings/meeting",
                                                                              locals: { meeting: @meeting })
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meetings/1/songs/1
  def update
    if @song.update(song_params)
      respond_to do |format|
        format.html do
          redirect_to @song, notice: t("controllers.songs_controller.updated")
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("meeting_#{@meeting.id}", partial: "meetings/meeting",
                                                                              locals: { meeting: @meeting })
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /meetings/1/songs/1
  def destroy
    @song.destroy

    respond_to do |format|
      format.html do
        redirect_to songs_url, notice: t("controllers.songs_controller.destroyed")
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("meeting_#{@song.meeting.id}_song_#{@song.id}")
      end
    end
  end

  private

  def set_meeting
    @meeting = current_unit.meetings.find(params[:meeting_id])
  end

  def set_song
    @song = @meeting.songs.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:song_type, :title)
  end
end
