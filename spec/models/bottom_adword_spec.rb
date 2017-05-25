require "rails_helper"

RSpec.describe BottomAdword, type: :model do
  let!(:page_content){Nokogiri::HTML File.read([Rails.root, "/spec/content.txt"].join).gsub("\\", "")}
  
  describe "#total" do
    subject{BottomAdword.new(page_content).total}
    it{is_expected.to eq 0}
  end

  describe "#urls" do
    subject{BottomAdword.new(page_content).urls}
    it{is_expected.to eq []}
  end
end


