class CreateKeywordsJob < ActiveJob::Base
  queue_as :create_keyword

  def perform user_id, keyword
    keyword_params = ExtractPage.new(keyword).call
    Keyword.create keyword_params.merge(user_id: user_id,
      keyword: keyword)
  end
end
