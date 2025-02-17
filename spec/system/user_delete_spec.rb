require "rails_helper"

describe "Update a user role", :js do
  let(:unit) { units(:sunny_hills) }
  let(:bishopric_user) { users(:sunny_bishopric) }
  let(:music_user) { users(:sunny_music) }

  scenario "Bishopric user deletes a user" do
    login_as bishopric_user, scope: :user

    visit users_path
    music_user_element = page.find("#user_#{music_user.id}")
    expect(music_user_element).to have_text(music_user.name)
    delete_button = music_user_element.find(:xpath, "//a[@href='/users/#{music_user.id}']")

    accept_alert do
      delete_button.click
    end

    expect(page).to have_current_path(users_path)
    expect(page).not_to have_text(music_user.name)
    expect { music_user.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end
