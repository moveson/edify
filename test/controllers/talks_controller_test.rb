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

  test "should create talk when date and speaker_name are unique (html)" do
    assert_difference("Talk.count", 1) do
      post talks_url, params: { talk: { date: "2022-02-02", speaker_name: "Richardson, Jeffrey" } }
    end

    assert_redirected_to talk_url(Talk.last)
  end

  test "should create talk when date and speaker_name are unique (json)" do
    assert_difference("Talk.count", 1) do
      post talks_url, params: { format: :json,
                                  talk: { date: "2002-02-02", speaker_name: "Richardson, Jeffrey" } }
    end

    assert_response :created
  end

  test "should update talk when date and speaker_name exist (html)" do
    assert_no_difference("Talk.count") do
      post talks_url, params: { talk: { date: @talk.date, speaker_name: @talk.speaker_name } }
    end

    assert_redirected_to talk_url(Talk.last)
  end

  test "should update talk when date and speaker_name exist (json)" do
    assert_no_difference("Talk.count") do
      post talks_url, params: { format: :json,
                                  talk: { date: @talk.date, speaker_name: @talk.speaker_name } }
    end

    assert_response :ok
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
