require "rails_helper"

describe "Onboard a new user" do
  let(:new_unit_user) { users(:new_unit) }
  context "when the user has not requested access" do
    scenario "the user creates a new ward unit" do
      login_as new_unit_user, scope: :user
      navigate_to_onboard_page
      click_link "I need to set up my ward"

      expect(page).to have_text("Set Up A New Ward")
      fill_in :unit_name, with: "Fountain Valley Ward"
      expect { click_button "Create Ward" }.to change(Unit, :count).by(1)

      new_unit = Unit.last
      new_unit_user.reload
      expect(new_unit_user.unit).to eq(new_unit)
      expect(new_unit_user.role).to eq("bishopric")

      expect(page).to have_current_path(root_path)
      expect(page).to have_text("Fountain Valley Ward")
    end
  end

  context "when the user has requested access" do
    let(:existing_unit) { units(:pleasant_forest) }

    context "when the user is not on the existing ward roster" do
      scenario "the user requests access to an existing ward unit" do
        login_as new_unit_user, scope: :user
        navigate_to_onboard_page
        click_link "My ward already uses Edify"

        expect(page).to have_text("Request Access")
        fill_in :access_request_unit_name, with: existing_unit.name
        expect { click_button "Submit Request" }.not_to change(Unit, :count)

        new_unit_user.reload
        expect(new_unit_user.unit).to be_nil
        expect(new_unit_user.role).to be_nil
        expect(new_unit_user.access_request).to be_nil

        expect(page).to have_current_path(new_access_request_path)
        expect(page).to have_text("We could not find #{new_unit_user.email} in the roster of #{existing_unit.name}")
      end
    end

    context "when the user is on the existing ward roster" do
      before { new_unit_user.update(email: existing_unit.members.last.email) }

      scenario "the user requests access to an existing ward unit" do
        login_as new_unit_user, scope: :user
        navigate_to_onboard_page
        click_link "My ward already uses Edify"

        expect(page).to have_text("Request Access")
        fill_in :access_request_unit_name, with: existing_unit.name
        expect { click_button "Submit Request" }.not_to change(Unit, :count)

        new_unit_user.reload
        expect(new_unit_user.unit).to be_nil
        expect(new_unit_user.role).to be_nil
        expect(new_unit_user.access_request).to be_present
        expect(new_unit_user.access_request.unit).to eq(existing_unit)
        expect(new_unit_user.access_request.status).to eq(:pending)

        expect(page).to have_current_path(root_path)
        expect(page).to have_text("Your request for access to #{existing_unit.name} is pending")
      end
    end

    context "when the user is on the existing ward roster but email case is inconsistent" do
      before do
        new_unit_user.update(email: existing_unit.members.last.email)
        existing_unit.members.last.update(email: existing_unit.members.last.email.upcase)
      end

      scenario "the user requests access to an existing ward unit" do
        login_as new_unit_user, scope: :user
        navigate_to_onboard_page
        click_link "My ward already uses Edify"

        expect(page).to have_text("Request Access")
        fill_in :access_request_unit_name, with: existing_unit.name
        expect { click_button "Submit Request" }.not_to change(Unit, :count)

        new_unit_user.reload
        expect(new_unit_user.unit).to be_nil
        expect(new_unit_user.role).to be_nil
        expect(new_unit_user.access_request).to be_present
        expect(new_unit_user.access_request.unit).to eq(existing_unit)
        expect(new_unit_user.access_request.status).to eq(:pending)

        expect(page).to have_current_path(root_path)
        expect(page).to have_text("Your request for access to #{existing_unit.name} is pending")
      end
    end
  end

  def navigate_to_onboard_page
    visit root_path
    click_link "Assign my Ward Unit"

    expect(page).to have_text("Assign My Ward Unit")
    expect(page).to have_link("My ward already uses Edify", href: new_access_request_path)
    expect(page).to have_link("I need to set up my ward", href: new_unit_path)
  end
end
