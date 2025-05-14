require "rails_helper"

describe "Visitor signs up" do
  scenario "with complete and valid information" do
    navigate_to_sign_up_page

    expect do
      within("form") do
        fill_in "Full name", with: "Brand New User"
        fill_in "Email address", with: "newuser@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirm password", with: "password"
        click_button "Sign up"
      end

      expect(page).to have_current_path(root_path)
    end.to change(User, :count).by(1)

    expect(page).to have_content("A message with a confirmation link has been sent to your email address")
  end

  scenario "with no information" do
    navigate_to_sign_up_page

    expect do
      within("form") { click_button "Sign up" }
    end.not_to change(User, :count)

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("First name can't be blank")
  end

  scenario "with invalid information" do
    navigate_to_sign_up_page

    expect do
      within("form") do
        fill_in "Full name", with: "Brand New User"
        fill_in "Email address", with: "newuser"
        fill_in "Password", with: "password"
        fill_in "Confirm password", with: "password"
        click_button "Sign up"
      end
    end.not_to change(User, :count)

    expect(page).to have_content("Email is invalid")
  end

  scenario "with passwords that don't match" do
    navigate_to_sign_up_page

    expect do
      within("form") do
        fill_in "Full name", with: "Brand New User"
        fill_in "Email address", with: "newuser@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirm password", with: "wrongpassword"
        click_button "Sign up"
      end
    end.not_to change(User, :count)

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  def navigate_to_sign_up_page
    visit root_path
    click_link "Sign Up"
    expect(page).to have_current_path(new_user_registration_path)
  end
end
