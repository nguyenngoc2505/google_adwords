module KeywordHelper
  def get_url_from urls, total
    keyword_urls = if total.zero?
                     total.to_s
                   else
                     urls = urls.map do |url|
                       "<li><a href='#{url}' target='_blank'>#{url}</a></li>"
                     end.join("")
                     <<-ELEMENT
                       <a data-reveal-id='keywordModal'
                         data-my-url="#{urls}">#{total}</a>
                     ELEMENT
                   end
    safe_join [keyword_urls.html_safe]
  end
end
