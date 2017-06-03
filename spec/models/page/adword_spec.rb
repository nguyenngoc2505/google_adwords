require "rails_helper"

RSpec.describe Page::Adword, type: :model do
  let!(:page_content) do
    Nokogiri::HTML File.read([Rails.root, "/spec/fixtures/content.txt"].join)
      .gsub("\\", "")
  end

  describe "#total" do
    subject{Page::Adword.new(page_content).total}
    it{is_expected.to eq 2}
  end
end
