# frozen_string_literal: true

require "rails_helper"

describe ::Unit, type: :model do
  describe "#next_available_sunday" do
    subject { units(:sunny_hills) }
    let(:result) { subject.next_available_sunday }
    before { travel_to(test_date) }
    after { travel_back }

    context "when the upcoming Sunday does not have a meeting scheduled" do
      let(:test_date) { "2022-05-02" }

      it "returns the upcoming Sunday" do
        expect(result).to eq("2022-05-08".to_date)
      end

      context "when there is a meeting scheduled on the upcoming Saturday" do
        before { subject.meetings.create!(date: "2022-05-07", meeting_type: :stake_conference) }

        it "returns the upcoming Sunday" do
          expect(result).to eq("2022-05-08".to_date)
        end
      end
    end

    context "when the upcoming Sunday has a meeting scheduled but the next does not" do
      let(:test_date) { "2022-04-30" }

      it "returns the first available Sunday" do
        expect(result).to eq("2022-05-08".to_date)
      end
    end

    context "when several upcoming Sundays have meetings scheduled" do
      let(:test_date) { "2022-03-25" }

      it "returns the first available Sunday" do
        expect(result).to eq("2022-05-08".to_date)
      end
    end

    context "when there are no meetings scheduled in the future" do
      let(:test_date) { "2022-05-16" }

      it "returns the first available Sunday" do
        expect(result).to eq("2022-05-22".to_date)
      end
    end
  end
end
