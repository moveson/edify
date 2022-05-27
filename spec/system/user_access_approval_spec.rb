# frozen_string_literal: true

require "rails_helper"

describe "Handle access request by a new user", type: :system do
  let(:reviewing_user) { users(:sunny_bishopric) }
  let(:requesting_user) { users(:unassigned) }
  let(:access_request) { requesting_user.access_request }

  context "when access is granted" do
    scenario "with bishopric role" do
      login_as reviewing_user, scope: :user
      navigate_to_review_screen

      find("#role").find(:xpath, "option[contains(text(), 'Bishopric')]").select_option
      click_button("Approve")

      expect(page).to have_current_path(users_path)
      requesting_user.reload
      expect(requesting_user.unit).to eq(reviewing_user.unit)
      expect(requesting_user.role).to eq("bishopric")

      access_request.reload
      expect(access_request).to be_approved
    end

    scenario "with music role" do
      login_as reviewing_user, scope: :user
      navigate_to_review_screen

      find("#role").find(:xpath, "option[contains(text(), 'Music')]").select_option
      click_button("Approve")

      expect(page).to have_current_path(users_path)
      requesting_user.reload
      expect(requesting_user.unit).to eq(reviewing_user.unit)
      expect(requesting_user.role).to eq("music")

      access_request.reload
      expect(access_request).to be_approved
    end
  end

  context "when access is rejected" do
    before { driven_by :selenium_chrome_headless }

    scenario "Access request is rejected" do
      login_as reviewing_user, scope: :user
      navigate_to_review_screen

      accept_alert do
        click_link("Reject")
      end

      expect(page).to have_current_path(users_path)
      requesting_user.reload
      expect(requesting_user.unit).to be_nil
      expect(requesting_user.role).to be_nil

      access_request.reload
      expect(access_request).to be_rejected
    end
  end

  def navigate_to_review_screen
    visit users_path
    expect(page).to have_text("Access Requests")
    click_link("Review", href: review_access_request_path(access_request))

    expect(page).to have_text("Review Access Request")
  end
end
