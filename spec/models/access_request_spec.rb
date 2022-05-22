# frozen_string_literal: true

require "rails_helper"

describe ::AccessRequest, type: :model do
  subject { access_requests(:access_request_1) }

  describe "validations" do
    context "when a request is approved" do
      context "with a valid approved role" do
        let(:approved_role) { "clerk" }
        it "is valid" do
          subject.update(approved_by: 1, approved_at: Time.current, approved_role: approved_role)
          expect(subject).to be_valid
        end
      end

      context "with an invalid approved role" do
        let(:approved_role) { "admin" }
        it "is invalid" do
          subject.update(approved_by: 1, approved_at: Time.current, approved_role: approved_role)
          expect(subject).not_to be_valid
          expect(subject.errors.full_messages).to include("Approved role cannot be admin")
        end
      end

      context "when approved role is an empty string" do
        let(:approved_role) { "" }
        it "is invalid" do
          subject.update(approved_by: 1, approved_at: Time.current, approved_role: approved_role)
          expect(subject).not_to be_valid
          expect(subject.errors.full_messages).to include("Approved role must exist when access request is approved")
        end
      end

      context "when approved role is nil" do
        let(:approved_role) { nil }
        it "is invalid" do
          subject.update(approved_by: 1, approved_at: Time.current, approved_role: approved_role)
          expect(subject).not_to be_valid
          expect(subject.errors.full_messages).to include("Approved role must exist when access request is approved")
        end
      end
    end
  end

  describe "callbacks" do
    context "when a request is updated with approval attributes" do
      let(:attributes) do
        {
          approved_at: Time.current,
          approved_by: 1,
          approved_role: "clerk",
          rejected_at: nil,
          rejected_by: nil,
        }
      end

      it "makes a call to conform the user" do
        expect(ConformUserToAccessRequest).to receive(:perform!).with(subject)
        subject.update(attributes)
      end
    end

    context "when a request is updated with rejection attributes" do
      let(:attributes) do
        {
          approved_at: nil,
          approved_by: nil,
          approved_role: nil,
          rejected_at: Time.current,
          rejected_by: 1,
        }
      end

      it "makes a call to conform the user" do
        expect(ConformUserToAccessRequest).to receive(:perform!).with(subject)
        subject.update(attributes)
      end
    end
  end
end
