# frozen_string_literal: true

require "test_helper"

class TalksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @talk = talks(:one)
    @member = members(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get talks_url
    assert_response :success
  end

  test "should get new" do
    get new_talk_url
    assert_response :success
  end

  test "should create talk" do
    assert_difference("Talk.count", 1) do
      post talks_url, params: { talk: { date: "2022-03-31", member_id: @member.id, purpose: "Stake Representative", topic: "Goodness" } }
    end

    assert_redirected_to talk_url(Talk.last)
  end

  test "should show talk" do
    get talk_url(@talk)
    assert_response :success
  end

  test "should get edit" do
    get edit_talk_url(@talk)
    assert_response :success
  end

  test "should update talk" do
    patch talk_url(@talk), params: { talk: { date: @talk.date, member_id: @talk.member_id, purpose: @talk.purpose, topic: @talk.topic } }
    assert_redirected_to talk_url(@talk)
  end

  test "should destroy talk" do
    assert_difference("Talk.count", -1) do
      delete talk_url(@talk)
    end

    assert_redirected_to talks_url
  end
end
