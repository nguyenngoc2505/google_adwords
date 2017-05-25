class KeywordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!

  layout :get_layout

  def index
    @keywords = current_user.keywords.order_by_keyword.page(params[:page]).per 10
  end

  def show
    @keyword = current_user.keywords.find params[:id]
  end

  def create
    if keywords = ParseKeywordsService.new(params[:keywords]).extract
      keywords.each{|k| CreateKeywordsJob.perform_later current_user.id, k}
      redirect_to root_path
    else
      redirect_to root_path
    end
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
