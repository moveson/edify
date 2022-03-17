# frozen_string_literal: true

require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @member = members(:one)
    sign_in users(:one)
  end

  test "visiting the index" do
    visit members_url
    assert_selector "h1", text: "Members"
  end
end
