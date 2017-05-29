require "rails_helper"

RSpec.describe Page::TopAdword, type: :model do
  let!(:page_content){Nokogiri::HTML File.read([Rails.root, "/spec/fixtures/content.txt"].join).gsub("\\", "")}
  
  describe "#total" do
    subject{Page::TopAdword.new(page_content).total}
    it{is_expected.to eq 2}
  end

  describe "#urls" do
    subject{Page::TopAdword.new(page_content).urls}
    it{is_expected.to eq ["www.google.com.vn/AdWords", "online.essex.ac.uk/distance/courses"]}
  end
end


