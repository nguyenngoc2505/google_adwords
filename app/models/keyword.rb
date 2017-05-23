class Keyword < ApplicationRecord
  belongs_to :user

  validates :user, :keyword, :top_adwords_count, :bottom_adwords_count,
    :adwords_count, :non_adwords_count, :total_urls, :total_results,
    :content, presence: true
  validates :top_adwords_count, :bottom_adwords_count, :adwords_count,
    :non_adwords_count, :total_results,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
