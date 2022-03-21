# frozen_string_literal: true

require "test_helper"

class MembersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @member = members(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get members_url
    assert_response :success
  end

  test "should get new" do
    get new_member_url
    assert_response :success
  end

  test "should create member" do
    assert_difference("Member.count", 1) do
      post members_url, params: { member: { birthdate: "2002-02-02", email: "test@test.com", gender: :male, name: "Richardson, Jeffrey", phone: "303-333-3333" } }
    end

    assert_redirected_to member_url(Member.last)
  end

  test "should show member" do
    get member_url(@member)
    assert_response :success
  end

  test "should get edit" do
    get edit_member_url(@member)
    assert_response :success
  end

  test "should update member" do
    patch member_url(@member), params: { member: { birthdate: @member.birthdate, email: "updated@email.com", gender: @member.gender, name: @member.name, phone: @member.phone } }
    @member.reload
    assert_equal(@member.email, "updated@email.com")
    assert_redirected_to member_url(@member)
  end

  test "should destroy member" do
    assert_difference("Member.count", -1) do
      delete member_url(@member)
    end

    assert_redirected_to members_url
  end

  test "should create member using upsert when birthdate and name are unique" do
    assert_difference("Member.count", 1) do
      post upsert_members_url, params: { format: :json,
                                         member: { birthdate: "2002-02-02", email: "test@test.com", gender: :male, name: "Richardson, Jeffrey", phone: "303-333-3333" } }
    end

    assert_response :created
  end

  test "should update member using upsert when birthdate and name exist" do
    assert_no_difference("Member.count") do
      post upsert_members_url, params: { format: :json,
                                         member: { birthdate: @member.birthdate, email: "test@test.com", gender: :male, name: @member.name, phone: "303-333-3333" } }
    end

    assert_response :ok
  end
end
