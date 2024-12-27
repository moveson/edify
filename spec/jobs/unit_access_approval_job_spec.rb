# frozen_string_literal: true

require "rails_helper"

RSpec.describe UnitAccessApprovalJob, type: :job do
  subject { described_class.new }
  let(:unit) { units(:sunny_hills) }
  let(:user) { users(:sunny_bishopric) }

  it "enqueues the job" do
    expect { described_class.perform_later(unit: unit, user: user) }.to have_enqueued_job(described_class)
  end

  describe "#perform" do
    let(:perform_job) { subject.perform(unit: unit, user: user) }

    before { allow(::UnitAccessApprovalNotification).to receive(:deliver_later) }

    it "delivers a message" do
      mock_notification = instance_double(UnitAccessApprovalNotification)
      allow(UnitAccessApprovalNotification).to receive(:with).with(user: user).and_return(mock_notification)
      expect(mock_notification).to receive(:deliver_later).with(unit.users.approvers)

      perform_job
    end
  end
end
