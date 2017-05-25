require "rails_helper"

RSpec.describe Adword, type: :model do
  let!(:page_content){Nokogiri::HTML File.read([Rails.root, "/spec/content.txt"].join).gsub("\\", "")}
  
  describe "#total" do
    subject{Adword.new(page_content).total}
    it{is_expected.to eq 2}
  end
end


