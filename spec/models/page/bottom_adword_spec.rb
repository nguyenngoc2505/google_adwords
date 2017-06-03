require "rails_helper"

RSpec.describe Page::BottomAdword, type: :model do
  let!(:page_content) do
    Nokogiri::HTML File.read([Rails.root, "/spec/fixtures/content.txt"].join)
      .gsub("\\", "")
  end

  describe "#total" do
    subject{Page::BottomAdword.new(page_content).total}
    it{is_expected.to eq 0}
  end

  describe "#urls" do
    subject{Page::BottomAdword.new(page_content).urls}
    it{is_expected.to eq []}
  end
end
