require "rails_helper"

RSpec.describe "Navbar active state highlighting", type: :system do
  let(:user) { users(:sunny_clerk) }

  before do
    login_as user, scope: :user
  end

  it "highlights the active navigation link" do
    visit meetings_path

    within("nav.navbar") do
      expect(page).to have_css('a.nav-link.active', text: "Meetings")
      expect(page).not_to have_css('a.nav-link.active', text: "Talks")
    end
  end

  it "updates highlighting when navigating to different pages" do
    visit meetings_path
    within("nav.navbar") do
      expect(page).to have_css('a.nav-link.active', text: "Meetings")
    end

    visit talks_path
    within("nav.navbar") do
      expect(page).to have_css('a.nav-link.active', text: "Talks")
      expect(page).not_to have_css('a.nav-link.active', text: "Meetings")
    end
  end

  context "when user has LCR access" do
    let(:user) { users(:sunny_bishopric) }

    it "highlights Members link when on members page" do
      visit members_path

      within("nav.navbar") do
        expect(page).to have_css('a.nav-link.active', text: "Members")
      end
    end

    it "highlights Imports link when on imports page" do
      visit import_jobs_path

      within("nav.navbar") do
        expect(page).to have_css('a.nav-link.active', text: "Imports")
      end
    end
  end

  context "What's New and Notifications" do
    it "highlights What's New link when on announcements page" do
      visit announcements_path

      within("nav.navbar") do
        expect(page).to have_css('a.nav-link.active', text: "What's New")
      end
    end

    it "highlights notifications icon when on notifications page" do
      visit notifications_path

      within("nav.navbar") do
        # The notifications link contains an icon, so we check for the active class
        expect(page).to have_css('a.nav-link.active i.fa-bell')
      end
    end
  end

  context "dropdown menu items" do
    it "highlights Settings link in dropdown when on settings page" do
      visit settings_preferences_path

      within("nav.navbar") do
        # Open the dropdown
        find("#navbar-dropdown").click

        within("#nav-account-dropdown") do
          expect(page).to have_css('a.dropdown-item.active', text: "Settings")
        end
      end
    end

    it "highlights All Users link in dropdown when on users page" do
      visit users_path

      within("nav.navbar") do
        find("#navbar-dropdown").click

        within("#nav-account-dropdown") do
          expect(page).to have_css('a.dropdown-item.active', text: "All Users")
        end
      end
    end
  end
end
