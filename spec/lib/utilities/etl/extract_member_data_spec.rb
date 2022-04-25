# frozen_string_literal: true

require "rails_helper"
require "utilities/etl"

describe ::Etl::ExtractMemberData do
  subject { described_class.new(import_job) }

  let(:unit) { units(:sunny_hills) }
  let(:import_job) { unit.import_jobs.create!(status: :waiting) }

  describe "#perform" do
    let(:result) { subject.perform }

    context "when a valid raw_data file is attached" do
      before { import_job.raw_data.attach(io: File.open(file_fixture("raw_member_list.txt")), filename: "raw_data.txt", content_type: "text/plain") }

      it "returns raw member rows" do
        expect(result.count).to eq(5)
        expect(result).to all be_a(::Etl::RawMemberRow)

        expect(result.first.name).to eq("Bins, Froederick")
        expect(result.first.gender).to eq("M")
        expect(result.first.birthdate.to_date).to eq("1943-02-22".to_date)
        expect(result.first.phone_number).to eq("(801) 545-4545")
        expect(result.first.email).to eq("froederick@frank.com")

        expect(result.last.name).to eq("Heidenrick, Kenneth")
        expect(result.last.gender).to eq("M")
        expect(result.last.birthdate.to_date).to eq("1963-07-01".to_date)
        expect(result.last.phone_number).to eq("385-348-3585")
        expect(result.last.email).to eq("heidenrick@kenneth.com")
      end
    end
  end
end
