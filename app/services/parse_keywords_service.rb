require "csv"

class ParseKeywordsService
  LIMIT_KEYWORDS = 1000

  def initialize file
    @file = file
  end

  def extract
    return if invalid_file? || invalid_content?
    content
  end

  private
  attr_reader :file

  def invalid_file?
    file.try(:content_type) != "text/csv"
  end

  def content
    @content ||= CSV.read(file.tempfile).flatten
  rescue
    []
  end

  def invalid_content?
    content.count.zero? || content.any?(&:blank?) ||
      content.count > LIMIT_KEYWORDS
  end
end
