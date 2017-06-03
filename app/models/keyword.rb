class Keyword < ApplicationRecord
  belongs_to :user

  serialize :top_adwords_urls, Array
  serialize :bottom_adwords_urls, Array
  serialize :non_adwords_urls, Array

  validates :user, :keyword, :top_adwords_count, :bottom_adwords_count,
    :adwords_count, :non_adwords_count, :total_urls, :total_results,
    :content, presence: true
  validates :top_adwords_count, :bottom_adwords_count, :adwords_count,
    :total_urls, :non_adwords_count, numericality: {only_integer: true,
      greater_than_or_equal_to: 0}

  scope(:order_by_keyword, ->{order(keyword: :asc)})
end
