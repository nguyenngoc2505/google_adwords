require "rails_helper"

RSpec.describe Keyword, type: :model do
  describe "validations" do
    it{should validate_presence_of(:user)}
    it{should validate_presence_of(:keyword)}
    it{should validate_presence_of(:top_adwords_count)}
    it{should validate_presence_of(:bottom_adwords_count)}
    it{should validate_presence_of(:adwords_count)}
    it{should validate_presence_of(:non_adwords_count)}
    it{should validate_presence_of(:total_urls)}
    it{should validate_presence_of(:content)}

    it{should validate_numericality_of(:top_adwords_count).only_integer.is_greater_than_or_equal_to(0)}
    it{should validate_numericality_of(:bottom_adwords_count).only_integer.is_greater_than_or_equal_to(0)}
    it{should validate_numericality_of(:adwords_count).only_integer.is_greater_than_or_equal_to(0)}
    it{should validate_numericality_of(:non_adwords_count).only_integer.is_greater_than_or_equal_to(0)}
    it{should validate_numericality_of(:total_urls).only_integer.is_greater_than_or_equal_to(0)}
  end

  describe "::order_by_keyword" do
    let!(:keyword_1){FactoryGirl.create(:keyword, keyword: "b test")}
    let!(:keyword_2){FactoryGirl.create(:keyword, keyword: "a test")}
    subject{Keyword.order_by_keyword}
    it{is_expected.to eq([keyword_2, keyword_1])}
  end
end
