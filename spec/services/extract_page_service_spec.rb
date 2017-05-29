require "rails_helper"
require "extract_page_service"

RSpec.describe ExtractPageService, type: :class do
  describe "#call" do
    subject{ExtractPageService.new("test").call}
    it{is_expected.to include(:top_adwords_count, :bottom_adwords_count, :adwords_count,
      :non_adwords_count, :top_adwords_urls, :bottom_adwords_urls, :non_adwords_urls,
      :total_urls, :total_results, :content)}
  end
end
