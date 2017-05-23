class Adword < Page
  def total
    adword_elements.css(".ads-ad").count
  end

  private
  def adword_elements
    page_content.css "._Ak"
  end
end
