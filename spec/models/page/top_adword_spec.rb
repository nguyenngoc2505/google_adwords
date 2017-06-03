require "rails_helper"

RSpec.describe Page::TopAdword, type: :model do
  let!(:page_content) do
    Nokogiri::HTML File.read([Rails.root, "/spec/fixtures/content.txt"].join)
      .gsub("\\", "")
  end

  describe "#total" do
    subject{Page::TopAdword.new(page_content).total}
    it{is_expected.to eq 2}
  end

  describe "#urls" do
    subject{Page::TopAdword.new(page_content).urls}
    it do
      result = ["www.google.com.vn/AdWords",
        "online.essex.ac.uk/distance/courses"]
      is_expected.to eq result
    end
  end
end
