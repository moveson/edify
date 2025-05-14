require "rails_helper"

describe "Update a user role", :js do
  let(:unit) { units(:sunny_hills) }
  let(:bishopric_user) { users(:sunny_bishopric) }
  let(:music_user) { users(:sunny_music) }

  scenario "Bishopric user changes a user from music to clerk" do
    login_as bishopric_user, scope: :user

    visit users_path
    music_user.reload
    expect(music_user.role).to eq("music")

    music_user_element = page.find("#user_#{music_user.id}")
    expect(music_user_element).to have_text(music_user.name)
    edit_button = music_user_element.find(:xpath, "//a[@href='/users/#{music_user.id}/edit']")
    edit_button.click

    music_user_element.find_by_id("user_role").find(:xpath, "option[contains(text(), 'Clerk')]").select_option
    music_user_element.find('[type="submit"]').click

    expect(page).to have_current_path(users_path)
    expect(music_user_element).to have_text(music_user.name)
    music_user.reload
    expect(music_user.role).to eq("clerk")
  end
end
