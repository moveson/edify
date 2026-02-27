require "rails_helper"
require "yaml"

RSpec.describe "Action Cable config" do
  it "uses solid_cable in development and production" do
    config = YAML.safe_load_file(Rails.root.join("config/cable.yml"), aliases: true)

    expect(config.dig("development", "adapter")).to eq("solid_cable")
    expect(config.dig("production", "adapter")).to eq("solid_cable")
  end
end
