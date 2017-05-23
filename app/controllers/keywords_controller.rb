class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @keywords = Keyword.order_by_keyword.page(params[:page]).per 10
  end
end
