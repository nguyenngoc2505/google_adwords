require "csv"

class ParseKeywordsService
  LIMIT_KEYWORDS = 1000

  def initialize file_path
    @file_path = file_path
  end

  def extract
    return if invalid_content?
    content
  end

  private
  attr_reader :file_path

  def valid_file?
    `file --brief --mime-type #{file_path}`.strip == "text/plain"
  end

  def content
    @content ||= CSV.read(file_path).flatten
  rescue
    []
  end

  def invalid_content?
    content.count.zero? || content.any?(&:blank?) ||
      content.count > LIMIT_KEYWORDS
  end
end
