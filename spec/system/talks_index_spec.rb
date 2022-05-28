# frozen_string_literal: true

require "rails_helper"

describe "Visit the talks index", type: :system do
  let(:unit) { units(:sunny_hills) }
  let(:bishopric_user) { users(:sunny_bishopric) }
  let(:clerk_user) { users(:sunny_clerk) }
  let(:music_user) { users(:sunny_music) }
  let(:program_user) { users(:sunny_program) }
  let(:unassigned_user) { users(:unassigned) }
  let(:new_unit_user) { users(:new_unit) }

  context "when the user is a visitor" do
    it "does not permit access" do
      visit talks_path
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context "when the user is in a bishopric" do
    before { login_as bishopric_user, scope: :user }

    it "lists all talks" do
      visit talks_path
      verify_talks_present
    end
  end

  context "when the user is a clerk" do
    before { login_as clerk_user, scope: :user }

    it "lists all talks" do
      visit talks_path
      verify_talks_present
    end
  end

  context "when the user is a music person" do
    before { login_as music_user, scope: :user }

    it "does not permit access" do
      visit talks_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  context "when the user is a program person" do
    before { login_as program_user, scope: :user }

    it "does not permit access" do
      visit talks_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  context "when the user is not assigned to a ward" do
    before { login_as unassigned_user, scope: :user }

    it "does not permit access" do
      visit talks_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  def verify_talks_present
    expect(page).to have_text "Talks"

    unit.meetings.each do |meeting|
      meeting.talks.each do |talk|
        talk_card = page.find("#meeting_#{meeting.id}_talk_#{talk.id}")
        expect(talk_card).to have_text(talk.speaker_name)
      end
    end
  end
end
