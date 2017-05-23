class NonAdword < Page
  def total
    non_adword_content.count
  end

  def urls
    non_adword_content.map do |element|
      element = element.at_css("a")
      next unless element
      element["href"].scan(/q=(\S+)&sa=/).flatten.first
    end.compact
  end

  private
  def non_adword_elements
    @non_adword_elements ||= page_content.at_css "#ires"
  end

  def non_adword_content
    return [] unless non_adword_elements
    @non_adword_content ||= non_adword_elements.css ".g"
  end
end
