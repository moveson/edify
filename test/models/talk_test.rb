# frozen_string_literal: true

require "test_helper"

class TalkTest < ActiveSupport::TestCase
  test "on create should save member_id when speaker name corresponds to a member" do
    member = members(:one)
    talk = ::Talk.new(speaker_name: member.name, date: "2022-03-03")
    talk.save!
    assert_equal(member.id, talk.member_id)
  end

  test "on create should save without member_id when speaker name does not correspond to a member" do
    talk = ::Talk.new(speaker_name: "Member, Nonexistent", date: "2022-03-03")
    talk.save!

    assert_nil(talk.member_id)
  end

  test "on update should save member_id when speaker name changes to an existing member name" do
    member = members(:one)
    talk = ::Talk.create!(speaker_name: "Edwards, Lavell", date: "2022-03-03")
    assert_nil(talk.member_id)
    talk.update(speaker_name: member.name)
    assert_equal(member.id, talk.member_id)
  end

  test "on update should set member_id to nil when speaker name changes to a non-existent member name" do
    member = members(:one)
    talk = ::Talk.create!(speaker_name: member.name, date: "2022-03-03")
    assert_equal(member.id, talk.member_id)
    talk.update(speaker_name: "Edwards, Lavell")
    assert_nil(talk.member_id)
  end
end
