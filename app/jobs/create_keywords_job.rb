class CreateKeywordsJob < ActiveJob::Base
  queue_as :default

  def perform user_id, keyword
    keyword_params = ExtractPageService.new(keyword).call
    Keyword.create keyword_params.merge(user_id: user_id,
      keyword: keyword)
  end
end
