require "rails_helper"

RSpec.describe MeetingScheduleNotifyJob, type: :job do
  subject { described_class.new }

  it "enqueues the job" do
    expect { described_class.perform_later }.to have_enqueued_job(described_class)
  end

  describe "#perform" do
    let(:perform_job) { subject.perform }

    before { allow(::CheckMeetingsAndNotify).to receive(:perform!) }

    it "sends a message to CheckMeetingsAndNotify for each unit" do
      expect(Unit.any?).to eq(true)
      Unit.find_each { |unit| expect(::CheckMeetingsAndNotify).to receive(:perform!).with(unit) }
      perform_job
    end
  end
end
