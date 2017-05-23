class BottomAdword < Page
  def total
    bottom_adword_content.count
  end

  def urls
    bottom_adword_content.map(&:inner_text).flatten
  end

  private
  def bottom_adword_elements
    @bottom_adword_elements ||= page_content.at_css "#_Ktg"
  end

  def bottom_adword_content
    return [] unless bottom_adword_elements
    @bottom_adword_content ||= bottom_adword_elements.css ".ads-visurl ._WGk"
  end
end
