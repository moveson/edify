# frozen_string_literal: true

require "rails_helper"

describe ::AccessRequest, type: :model do
  subject { described_class.create(user: user, unit: unit) }
  let(:user) { users(:unapproved) }
  let(:unit) { units(:sunny_hills) }

  describe "validations" do
    context "on approval" do
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
end
