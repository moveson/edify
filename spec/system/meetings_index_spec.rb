require "rails_helper"

describe "Visit the meetings index" do
  let(:unit) { units(:sunny_hills) }
  let(:bishopric_user) { users(:sunny_bishopric) }
  let(:clerk_user) { users(:sunny_clerk) }
  let(:music_user) { users(:sunny_music) }
  let(:program_user) { users(:sunny_program) }
  let(:unassigned_user) { users(:unassigned) }
  let(:new_unit_user) { users(:new_unit) }

  context "when the user is a visitor" do
    it "does not permit access" do
      visit meetings_path
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context "when the user is in a bishopric" do
    before { login_as bishopric_user, scope: :user }

    it "lists all meetings with scheduling tools" do
      visit meetings_path
      verify_meetings_present
      verify_meeting_scheduling_tools_present
      verify_talk_scheduling_tools_present
    end
  end

  context "when the user is a clerk" do
    before { login_as clerk_user, scope: :user }

    it "lists all meetings but not scheduling tools" do
      visit meetings_path
      verify_meetings_present
      verify_meeting_scheduling_tools_absent
      verify_talk_scheduling_tools_absent
    end
  end

  context "when the user is a music person" do
    before { login_as music_user, scope: :user }

    it "lists all meetings with scheduling tools" do
      visit meetings_path
      verify_meetings_present
      verify_meeting_scheduling_tools_present
      verify_talk_scheduling_tools_absent
    end
  end

  context "when the user is a program person" do
    before { login_as program_user, scope: :user }

    it "lists all meetings but not scheduling tools" do
      visit meetings_path
      verify_meetings_present
      verify_meeting_scheduling_tools_absent
      verify_talk_scheduling_tools_absent
    end
  end

  context "when the user is not assigned to a ward" do
    before { login_as unassigned_user, scope: :user }

    it "does not permit access" do
      visit meetings_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  def verify_meetings_present
    expect(page).to have_text "Meetings"

    unit.meetings.each do |meeting|
      meeting_card = page.find("#meeting_#{meeting.id}")
      meeting.talks.each do |talk|
        expect(meeting_card).to have_text(talk.speaker_name)
      end
    end
  end

  def verify_meeting_scheduling_tools_present
    expect(page).to have_link(href: new_meeting_path)

    unit.meetings.each do |meeting|
      meeting_card = page.find("#meeting_#{meeting.id}")
      expect(meeting_card).to have_link(href: edit_meeting_path(meeting))
    end
  end

  def verify_talk_scheduling_tools_present
    unit.meetings.each do |meeting|
      meeting_card = page.find("#meeting_#{meeting.id}")
      expect(meeting_card).to have_link(href: new_meeting_talk_path(meeting))
      expect(meeting_card).to have_link(href: meeting_path(meeting))

      meeting.talks.each do |talk|
        expect(meeting_card).to have_link(href: edit_meeting_talk_path(meeting, talk))
        expect(meeting_card).to have_link(href: meeting_talk_path(meeting, talk))
      end
    end
  end

  def verify_meeting_scheduling_tools_absent
    expect(page).not_to have_link(href: new_meeting_path)

    unit.meetings.each do |meeting|
      meeting_card = page.find("#meeting_#{meeting.id}")
      expect(meeting_card).not_to have_link(href: edit_meeting_path(meeting))
    end
  end

  def verify_talk_scheduling_tools_absent
    unit.meetings.each do |meeting|
      meeting_card = page.find("#meeting_#{meeting.id}")
      expect(meeting_card).not_to have_link(href: new_meeting_talk_path(meeting))
      expect(meeting_card).not_to have_link(href: meeting_path(meeting))

      meeting.talks.each do |talk|
        expect(meeting_card).not_to have_link(href: edit_meeting_talk_path(meeting, talk))
        expect(meeting_card).not_to have_link(href: meeting_talk_path(meeting, talk))
      end
    end
  end
end
