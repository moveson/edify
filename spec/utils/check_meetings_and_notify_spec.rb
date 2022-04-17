# frozen_string_literal: true

require "rails_helper"

describe CheckMeetingsAndNotify do
  subject { described_class.new(unit) }

  let(:unit) { units(:sunny_hills) }

  before do
    allow(::MissingMeetingsNotification).to receive(:with).and_call_original
    allow(::IncompleteMeetingNotification).to receive(:with).and_call_original
    allow_any_instance_of(::MissingMeetingsNotification).to receive(:deliver_later)
    allow_any_instance_of(::IncompleteMeetingNotification).to receive(:deliver_later)
    travel_to(test_date)
  end

  context "when there are unscheduled meetings in the relevant timeframe" do
    let(:test_date) { "2022-04-30" }
    let(:expected_missing_dates) { ["2022-05-08", "2022-05-22"].map(&:to_date) }

    it "sends notifications of missing dates to unit users" do
      expect(::MissingMeetingsNotification).to receive(:with).with(dates: expected_missing_dates)
      expect_any_instance_of(::MissingMeetingsNotification).to receive(:deliver_later).with(unit.users)
      subject.perform!
    end
  end

  context "when there are no unscheduled meetings in the relevant timeframe" do
    let(:test_date) { "2022-04-01" }

    it "does not send missing meeting notifications" do
      expect(::MissingMeetingsNotification).not_to receive(:with)
      expect_any_instance_of(::MissingMeetingsNotification).not_to receive(:deliver_later)
      subject.perform!
    end
  end

  context "when there are incomplete meetings in the relevant timeframe" do
    let(:test_date) { "2022-04-30" }
    let(:incomplete_meeting) { unit.meetings.find_by(date: "2022-05-15") }

    context "when the meeting has no scheduler" do
      it "sends an incomplete meeting notification to unit users" do
        expect(::IncompleteMeetingNotification).to receive(:with).with(meeting: incomplete_meeting)
        expect_any_instance_of(::IncompleteMeetingNotification).to receive(:deliver_later).with(unit.users)
        subject.perform!
      end
    end

    context "when the meeting has a scheduler" do
      let(:scheduler) { unit.users.first }
      before { incomplete_meeting.update(scheduler: scheduler) }

      it "sends an incomplete meeting notification to the scheduler" do
        expect(::IncompleteMeetingNotification).to receive(:with).with(meeting: incomplete_meeting)
        expect_any_instance_of(::IncompleteMeetingNotification).to receive(:deliver_later).with(scheduler)
        subject.perform!
      end
    end
  end

  context "when there are no incomplete meetings in the relevant timeframe" do
    let(:test_date) { "2022-04-01" }
    before do
      unit.meetings.find_by(date: "2022-04-17").update(meeting_type: :stake_conference)
      unit.meetings.find_by(date: "2022-04-24").update(meeting_type: :testimony_meeting)
    end

    it "does not send an incomplete meeting notification" do
      expect(::IncompleteMeetingNotification).not_to receive(:with)
      expect_any_instance_of(::IncompleteMeetingNotification).not_to receive(:deliver_later)
      subject.perform!
    end
  end
end
