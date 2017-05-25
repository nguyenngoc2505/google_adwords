FactoryGirl.define do
  factory :keyword do
    association :user, factory: :user
    keyword "test"
    top_adwords_count 1
    bottom_adwords_count 1
    adwords_count 2
    non_adwords_count 10
    total_urls 90
    total_results 'About 1000.000 results'
    content '<title> GoogleAdword </title>'
  end
end
