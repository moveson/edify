require "test_helper"

class MemberTest < ActiveSupport::TestCase
  test "should be valid if youth" do
    member = Member.new(name: "Richardson, Jeffrey", gender: :male, birthdate: 12.years.ago.to_date)
    member.valid?
    assert_empty(member.errors)
  end

  test "should be valid if adult" do
    member = Member.new(name: "Richardson, Jeffrey", gender: :male, birthdate: 25.years.ago.to_date)
    member.valid?
    assert_empty(member.errors)
  end

  test "should be valid if elderly" do
    member = Member.new(name: "Richardson, Jeffrey", gender: :male, birthdate: 90.years.ago.to_date)
    member.valid?
    assert_empty(member.errors)
  end

  test "should be invalid if primary age" do
    member = Member.new(name: "Richardson, Jeffrey", gender: :male, birthdate: 11.years.ago.to_date)
    member.valid?
    assert_not_empty(member.errors)
  end

  test "should be invalid if nursery age" do
    member = Member.new(name: "Richardson, Jeffrey", gender: :male, birthdate: 2.years.ago.to_date)
    member.valid?
    assert_not_empty(member.errors)
  end
end
