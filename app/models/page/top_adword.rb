class Page::TopAdword < Page
  def total
    top_adword_content.count
  end

  def urls
    top_adword_content.map(&:inner_text).flatten
  end

  private
  def top_adword_elements
    @top_adword_elements ||= page_content.at_css "#_Ltg"
  end

  def top_adword_content
    return [] unless top_adword_elements
    @top_adword_content ||= top_adword_elements.css ".ads-visurl ._WGk"
  end
end
