require "rails_helper"

describe ::Meeting do
  subject { described_class.new(date: date) }

  describe "#not_yet_occurred?" do
    let(:result) { subject.not_yet_occurred? }

    context "when the meeting is in the past" do
      let(:date) { 3.days.ago }
      it { expect(result).to eq(false) }
    end

    context "when the meeting is on the current date" do
      let(:date) { Date.current }
      it { expect(result).to eq(true) }
    end

    context "when the meeting is in the future" do
      let(:date) { 3.days.from_now }
      it { expect(result).to eq(true) }
    end
  end
end
