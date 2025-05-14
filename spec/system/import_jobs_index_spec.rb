require "rails_helper"

describe "Visit the import jobs index" do
  let(:unit) { units(:sunny_hills) }
  let(:bishopric_user) { users(:sunny_bishopric) }
  let(:clerk_user) { users(:sunny_clerk) }
  let(:music_user) { users(:sunny_music) }
  let(:program_user) { users(:sunny_program) }
  let(:unassigned_user) { users(:unassigned) }

  context "when the user is a visitor" do
    it "does not permit access" do
      visit import_jobs_path
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context "when the user is in a bishopric" do
    before { login_as bishopric_user, scope: :user }

    it "lists all import jobs" do
      visit import_jobs_path
      verify_expected_items_present
    end
  end

  context "when the user is a clerk" do
    before { login_as clerk_user, scope: :user }

    it "lists all import jobs" do
      visit import_jobs_path
      verify_expected_items_present
    end
  end

  context "when the user is a music person" do
    before { login_as music_user, scope: :user }

    it "does not permit access" do
      visit import_jobs_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  context "when the user is a program person" do
    before { login_as program_user, scope: :user }

    it "does not permit access" do
      visit import_jobs_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  context "when the user is not assigned to a ward" do
    before { login_as unassigned_user, scope: :user }

    it "does not permit access" do
      visit import_jobs_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Not authorized")
    end
  end

  def verify_expected_items_present
    expect(page).to have_text("Imports")
    expect(page).to have_link(href: new_import_job_path)
  end
end
