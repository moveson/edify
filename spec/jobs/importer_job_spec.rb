# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImporterJob, type: :job do
  subject { described_class.new }

  let(:import_job) { import_jobs(:import_job_7) }

  it "enqueues the job" do
    expect { described_class.perform_later(import_job: import_job) }.to have_enqueued_job(described_class)
  end

  describe "#perform" do
    let(:perform_job) { subject.perform(import_job: import_job) }

    before { allow(::Edify::Etl::ImportManager).to receive(:perform!) }

    it "sends a message to Edify::Etl::ImportManager for each unit" do
      expect(::Edify::Etl::ImportManager).to receive(:perform!).with(import_job)
      perform_job
    end
  end
end
