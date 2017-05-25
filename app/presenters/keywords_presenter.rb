class KeywordsPresenter
  JSON_ATTRIBUTES = %i(keyword top_adwords_count bottom_adwords_count
    adwords_count top_adwords_urls bottom_adwords_urls non_adwords_count
    non_adwords_urls total_urls total_results content)

  def initialize keywords
    @keywords = keywords
  end

  def as_json
    keywords.map{|keyword| keyword.slice *JSON_ATTRIBUTES}
  end

  private
  attr_reader :keywords
end
