require "open-uri"
require "nokogiri"

class ExtractPage
  DESTINATION_URL = "https://www.google.com/search?q=%s"
  AD_OBJECTS = %w(adword top_adword bottom_adword non_adword)

  def initialize keyword
    @keyword = keyword
  end

  def call
    {
      top_adwords_count: top_adword.total,
      bottom_adwords_count: bottom_adword.total,
      adwords_count: adword.total,
      non_adwords_count: non_adword.total,
      top_adwords_urls: top_adword.urls,
      bottom_adwords_urls: bottom_adword.urls,
      non_adwords_urls: non_adword.urls,
      total_urls: total_urls,
      total_results: total_results,
      content: page_content.try(:inner_html).to_s
    }
  end

  private
  attr_reader :keyword, :adword, :top_adword, :bottom_adword,
    :non_adword

  def page_content
    Nokogiri::HTML open(DESTINATION_URL%keyword).read, nil, "utf-8"
  end

  AD_OBJECTS.each do |ad_obj|
    instance_variable_set "@#{ad_obj}",
      ad_obj.camelize.constantize.new(page_content)
  end

  def total_urls
    page_content.css("a").count
  end

  def total_results
    page_content.at_css("#resultStats").text
  end
end
