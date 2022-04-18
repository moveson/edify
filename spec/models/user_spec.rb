# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::User, type: :model do
  subject { described_class.new }

  describe "constructor" do
    it "default email notifications to true" do
      expect(subject.notification_preference_email).to eq(true)
      expect(subject.notification_preference_sms).to eq(true)
    end
  end
end
