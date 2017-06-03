class KeywordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!

  layout :get_layout

  def index
    @keywords = current_user.keywords.order_by_keyword
      .page(params[:page]).per 10
  end

  def show
    @keyword = current_user.keywords.find params[:id]
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
