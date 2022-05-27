# frozen_string_literal: true

require "rails_helper"

describe "Visit the users index", type: :system do
  let(:unit) { units(:sunny_hills) }
  let(:admin) { users(:admin) }
  let(:bishopric_user) { users(:sunny_bishopric) }
  let(:clerk_user) { users(:sunny_clerk) }
  let(:music_user) { users(:sunny_music) }
  let(:program_user) { users(:sunny_program) }
  let(:unassigned_user) { users(:unassigned) }
  let(:new_unit_user) { users(:new_unit) }

  context "when the user is a visitor" do
    it "does not permit access" do
      visit users_path
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context "when the user is an admin without a unit assigned" do
    before { login_as admin, scope: :user }

    it "does not permit access" do
      visit users_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  context "when the user is in a bishopric" do
    before { login_as bishopric_user, scope: :user }

    it "lists all users and access requests" do
      visit users_path
      verify_users_present
      verify_access_requests_present
    end
  end

  context "when the user is a clerk" do
    before { login_as clerk_user, scope: :user }

    it "lists all users but not access requests" do
      visit users_path
      verify_users_present
      verify_access_requests_absent
    end
  end

  context "when the user is a music person" do
    before { login_as music_user, scope: :user }

    it "lists all users but not access requests" do
      visit users_path
      verify_users_present
      verify_access_requests_absent
    end
  end

  context "when the user is a program person" do
    before { login_as program_user, scope: :user }

    it "lists all users but not access requests" do
      visit users_path
      verify_users_present
      verify_access_requests_absent
    end
  end

  context "when the user is not assigned to the ward" do
    before { login_as unassigned_user, scope: :user }

    it "does not permit access" do
      visit users_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  def verify_users_present
    expect(page).to have_text "Users"

    unit.users.each do |user|
      expect(page).to have_text(user.name)
    end
  end

  def verify_access_requests_present
    expect(page).to have_text "Access Requests"

    unit.access_requests.each do |access_request|
      expect(page).to have_text(access_request.user.name)
    end
  end

  def verify_access_requests_absent
    expect(page).not_to have_text "Access Requests"

    unit.access_requests.each do |access_request|
      expect(page).not_to have_text(access_request.user.name)
    end
  end
end
