# frozen_string_literal: true

require "rails_helper"

describe MeetingsViewObject do
  subject { described_class.new(meetings, view_context, pagy) }

  let(:unit) { units(:sunny_hills) }
  let(:meetings) { unit.meetings }
  let(:view_context) { MeetingsController.new.view_context }
  let(:pagy) { Pagy.new(count: 1, page: 1) }

  before do
    allow(view_context).to receive(:current_user).and_return(unit.users.first)
  end

  describe "#current_meeting_id" do
    let(:result) { subject.current_meeting_id }

    context "when there is a meeting today" do
      before { travel_to("2022-04-10") }

      it "returns the id of the meeting" do
        expect(result).to eq(meetings.find_by(date: "2022-04-10").id)
      end
    end

    context "when there is no meeting today but there is one in the future" do
      before { travel_to("2022-04-11") }

      it "returns the id of the earliest future meeting" do
        expect(result).to eq(meetings.find_by(date: "2022-04-17").id)
      end
    end

    context "when there is no meeting today and none in the future" do
      before { travel_to("2022-05-25") }

      it "returns nil" do
        expect(result).to be_nil
      end
    end
  end

  describe "#filtered_count" do
    it "returns the number of meetings in the current pagy" do
      expect(subject.filtered_count).to eq(1)
    end
  end

  describe "#total_count" do
    it "returns the number of meetings in the unit" do
      expect(subject.total_count).to eq(7)
    end
  end
end
