# frozen_string_literal: true

require_relative "../../../lib/core_ext/string"
require "active_record"

RSpec.describe String do
  describe "#numeric?" do
    let(:result) { subject.numeric? }

    context "when the string is entirely digits" do
      subject { "1234" }
      it { expect(result).to eq(true) }
    end

    context "when the string represents a decimal" do
      subject { "1234.56" }
      it { expect(result).to eq(true) }
    end

    context "when the string is partially digits" do
      subject { "hello1234" }
      it { expect(result).to eq(false) }
    end

    context "when the string contains no digits" do
      subject { "hello" }
      it { expect(result).to eq(false) }
    end
  end
end
