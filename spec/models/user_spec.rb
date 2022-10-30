# frozen_string_literal: true

require "rails_helper"

describe ::User do
  subject { described_class.new(phone_number: phone_number) }

  let(:phone_number) { "303-303-0303" }

  describe "callbacks" do
    it "defaults email notifications to true" do
      subject.valid?
      expect(subject.notification_preference_email).to eq(true)
    end

    context "when phone number is present" do
      it "defaults sms notifications to true" do
        subject.valid?
        expect(subject.notification_preference_sms).to eq(true)
      end
    end

    context "when phone number is not present" do
      let(:phone_number) { nil }
      it "defaults sms notifications to false" do
        subject.valid?
        expect(subject.notification_preference_sms).to eq(false)
      end
    end
  end

  describe "admin?" do
    let(:result) { user.admin? }

    context "when the user is an admin" do
      let(:user) { users(:admin) }
      it "returns true" do
        expect(result).to eq(true)
      end
    end

    context "when the user is not an admin" do
      let(:user) { users(:sunny_bishopric) }
      it "returns false" do
        expect(result).to eq(false)
      end
    end
  end
end
