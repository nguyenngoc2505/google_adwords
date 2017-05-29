require "rails_helper"

RSpec.describe Page::Adword, type: :model do
  let!(:page_content){Nokogiri::HTML File.read([Rails.root, "/spec/fixtures/content.txt"].join).gsub("\\", "")}
  
  describe "#total" do
    subject{Page::Adword.new(page_content).total}
    it{is_expected.to eq 2}
  end
end


