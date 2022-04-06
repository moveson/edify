require "test_helper"

class MeetingTest < ActiveSupport::TestCase
  setup do
    travel_to "2022-03-01"
  end

  teardown do
    travel_back
  end

  test ".next_available_sunday when meetings are contiguous" do
    unit = units(:one)
    assert_equal("2022-03-20".to_date, Meeting.next_available_sunday(unit))
  end

  test ".next_available_sunday when meetings are not contiguous" do
    unit = units(:one)
    meeting = Meeting.order(:date).last
    meeting.update(date: "2022-03-20")
    assert_equal("2022-03-13".to_date, Meeting.next_available_sunday(unit))
  end

  test ".next_available_sunday when meetings are far in the future" do
    unit = units(:one)
    Meeting.first.update(date: "2022-05-01")
    Meeting.last.update(date: "2022-05-08")
    assert_equal("2022-03-06".to_date, Meeting.next_available_sunday(unit))
  end

  test ".next_available_sunday when only one meeting exists" do
    unit = units(:one)
    Talk.find_each(&:destroy)
    Meeting.order(:date).last.destroy
    assert_equal(1, Meeting.count)
    assert_equal("2022-03-13".to_date, Meeting.next_available_sunday(unit))
  end

  test ".next_available_sunday when meetings do not exist" do
    unit = units(:one)
    Talk.find_each(&:destroy)
    Meeting.find_each(&:destroy)
    assert_equal(0, Meeting.count)
    assert_equal("2022-03-06".to_date, Meeting.next_available_sunday(unit))
  end
end
