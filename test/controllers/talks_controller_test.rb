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
    get meeting_talks_url(@meeting)
    assert_response :success
  end

  test "should get new" do
    get new_talk_url
    assert_response :success
  end

  test "should create talk" do
    assert_difference("Talk.count", 1) do
      post talks_url, params: { talk: { date: "2022-02-02", speaker_name: "Richardson, Jeffrey" } }
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

  test "should create talk using upsert when date and speaker_name are unique" do
    assert_difference("Talk.count", 1) do
      post upsert_talks_url, params: { format: :json,
                                       talk: { date: "2002-02-02", speaker_name: "Richardson, Jeffrey" } }
    end

    assert_response :created
  end

  test "should update talk using upsert when date and speaker_name exist" do
    assert_no_difference("Talk.count") do
      post upsert_talks_url, params: { format: :json,
                                       talk: { date: @talk.date, speaker_name: @talk.speaker_name } }
    end

    assert_response :ok
  end
end
