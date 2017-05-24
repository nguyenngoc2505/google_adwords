class KeywordsController < ApplicationController
  before_action :authenticate_user!

  layout :get_layout

  def index
    @keywords = Keyword.order_by_keyword.page(params[:page]).per 10
  end

  def show
    @keyword = Keyword.find params[:id]
  end

  private
  def get_layout
    case action_name
    when "show"
      "keyword_page"
    else
      "application"
    end
  end
end
