# frozen_string_literal: true

require "rails_helper"

describe "Visit the home page" do
  let(:admin) { users(:admin) }
  let(:bishopric_user) { users(:sunny_bishopric) }
  let(:clerk_user) { users(:sunny_clerk) }
  let(:music_user) { users(:sunny_music) }
  let(:program_user) { users(:sunny_program) }
  let(:unassigned_user) { users(:unassigned) }
  let(:new_unit_user) { users(:new_unit) }

  scenario "The user is a visitor" do
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link("Sign Up", href: new_user_registration_path)
    expect(page).to have_link("Login", href: new_user_session_path)
  end

  scenario "The user is an admin user" do
    login_as admin, scope: :user
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link(href: notifications_path)
    expect(page).not_to have_link("Meetings", href: meetings_path)
    expect(page).not_to have_link("Members", href: members_path)
    expect(page).not_to have_link("Talks", href: talks_path)
    expect(page).not_to have_link("Imports", href: import_jobs_path)

    verify_admin_links_present
  end

  scenario "The user is a bishopric user" do
    login_as bishopric_user, scope: :user
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link(href: notifications_path)
    expect(page).to have_link("Meetings", href: meetings_path)
    expect(page).to have_link("Members", href: members_path)
    expect(page).to have_link("Talks", href: talks_path)
    expect(page).to have_link("Imports", href: import_jobs_path)

    verify_admin_links_absent
  end

  scenario "The user is a clerk user" do
    login_as clerk_user, scope: :user
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link(href: notifications_path)
    expect(page).to have_link("Meetings", href: meetings_path)
    expect(page).to have_link("Members", href: members_path)
    expect(page).to have_link("Talks", href: talks_path)
    expect(page).to have_link("Imports", href: import_jobs_path)

    verify_admin_links_absent
  end

  scenario "The user is a music user" do
    login_as music_user, scope: :user
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link(href: notifications_path)
    expect(page).to have_link("Meetings", href: meetings_path)
    expect(page).not_to have_link("Members", href: members_path)
    expect(page).not_to have_link("Talks", href: talks_path)
    expect(page).not_to have_link("Imports", href: import_jobs_path)

    verify_admin_links_absent
  end

  scenario "The user is a program user" do
    login_as program_user, scope: :user
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link(href: notifications_path)
    expect(page).to have_link("Meetings", href: meetings_path)
    expect(page).not_to have_link("Members", href: members_path)
    expect(page).not_to have_link("Talks", href: talks_path)
    expect(page).not_to have_link("Imports", href: import_jobs_path)

    verify_admin_links_absent
  end

  scenario "The user is an unassigned user with an outstanding access request" do
    login_as unassigned_user, scope: :user
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link(href: notifications_path)
    expect(page).to have_text("Your request for access to #{unassigned_user.access_request.unit_name} is pending")

    verify_admin_links_absent
  end

  scenario "The user is an unassigned user who has not requested access" do
    login_as new_unit_user, scope: :user
    visit root_path

    expect(page).to have_link("Edify", href: root_path)
    expect(page).to have_link(href: notifications_path)
    expect(page).to have_text("Looks like you aren't yet assigned to a Ward unit")
    expect(page).to have_link("Assign my Ward Unit", href: onboard_path)

    verify_admin_links_absent
  end

  def verify_admin_links_present
    expect(page).to have_link("Admin Area", href: madmin_root_path)
    expect(page).to have_link("Mission Control", href: mission_control_jobs_path)
  end

  def verify_admin_links_absent
    expect(page).not_to have_link("Admin Area")
    expect(page).not_to have_link(href: madmin_root_path)
    expect(page).not_to have_link("Mission Control")
    expect(page).not_to have_link(href: mission_control_jobs_path)
  end
end
