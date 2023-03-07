# frozen_string_literal: true

require "rails_helper"

describe ConformUserToAccessRequest do
  subject { described_class.new(access_request) }

  let(:access_request) { access_requests(:access_request_1) }
  let(:unit) { access_request.unit }
  let(:user) { access_request.user }

  context "when the access request is approved" do
    before do
      # Use update_columns to avoid running callbacks during setup
      access_request.update_columns(approved_at: Time.current, approved_by: 1, approved_role: :clerk)
    end

    it "adds a unit id and role to the user" do
      expect(user.unit).to be_nil
      expect(user.role).to be_nil

      subject.perform!

      expect(user.unit).to eq(unit)
      expect(user.role).to eq("clerk")
    end
  end

  context "when the access request is rejected" do
    before do
      # Use update_columns to avoid running callbacks during setup
      access_request.update_columns(rejected_at: Time.current, rejected_by: 1)
      user.update_columns(unit_id: units(:sunny_hills).id, role: :clerk)
    end

    it "adds a unit id and role to the user" do
      expect(user.unit).to eq(unit)
      expect(user.role).to eq("clerk")

      subject.perform!

      expect(user.unit).to be_nil
      expect(user.role).to be_nil
    end
  end
end
