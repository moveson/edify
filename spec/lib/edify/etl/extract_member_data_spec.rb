# frozen_string_literal: true

require "rails_helper"
require "edify/etl"

describe ::Edify::Etl::ExtractMemberData do
  subject { described_class.new(import_job) }

  let(:unit) { units(:sunny_hills) }
  let(:import_job) { unit.import_jobs.create!(status: :waiting) }

  describe "#perform" do
    let(:result) { subject.perform }

    context "when a valid raw_data file is attached" do
      before do
        import_job.raw_data.attach(io: File.open(file_fixture("raw_member_list.txt")),
                                   filename: "raw_data.txt",
                                   content_type: "text/plain")
      end

      it "returns raw member rows" do
        expect(result.count).to eq(6)
        expect(result).to all be_a(::Edify::Etl::RawMemberRow)

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

      it "removes unbaptized member of record indicators" do
        expect(result.second.name).to eq("Bode, Yolanda")
        expect(result.third.name).to eq("Jiminy, Theophilus")
      end
    end

    context "when the raw member data is incomplete" do
      before do
        import_job.raw_data.attach(io: File.open(file_fixture("raw_member_list_incomplete.txt")),
                                   filename: "raw_data.txt",
                                   content_type: "text/plain")
      end

      it "returns an empty array" do
        expect(result).to eq([])
      end

      it "adds a descriptive error" do
        expected_string = "Raw data could not be parsed. Please ensure you have copy/pasted the entire member list."
        subject.perform
        expect(import_job.errors).to be_present
        expect(import_job.errors.full_messages).to include(expected_string)
      end
    end

    context "when headers are not as expected" do
      before do
        import_job.raw_data.attach(io: File.open(file_fixture("raw_member_list_bad_headers.txt")),
                                   filename: "raw_data.txt",
                                   content_type: "text/plain")
      end

      it "returns an empty array" do
        expect(result).to eq([])
      end

      it "adds a descriptive error" do
        subject.perform
        expect(import_job.errors).to be_present
        expect(import_job.errors.full_messages).to include(/Raw data did not contain expected header Birth Date/)
        expect(import_job.errors.full_messages).to include(/Raw data did not contain expected header E-mail/)
      end
    end

    context "when no raw_data file is attached" do
      it "returns an empty array" do
        expect(result).to eq([])
      end

      it "adds a descriptive error" do
        subject.perform
        expect(import_job.errors).to be_present
        expect(import_job.errors.full_messages).to include(/Raw data was not provided/)
      end
    end
  end
end
