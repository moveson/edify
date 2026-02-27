require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#active_link_class" do
    it "returns 'active' when on the current page" do
      allow(helper).to receive(:current_page?).with("/meetings").and_return(true)
      expect(helper.active_link_class("/meetings")).to eq("active")
    end

    it "returns empty string when not on the current page" do
      allow(helper).to receive(:current_page?).with("/meetings").and_return(false)
      expect(helper.active_link_class("/meetings")).to eq("")
    end
  end
end
