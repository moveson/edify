# frozen_string_literal: true

require "application_system_test_case"

class TalksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @talk = talks(:one)
    sign_in users(:one)
  end

  test "visiting the index" do
    visit talks_url
    assert_selector "h1", text: "Talks"
  end
end
