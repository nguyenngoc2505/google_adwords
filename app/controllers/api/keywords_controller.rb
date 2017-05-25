class Api::KeywordsController < Api::BaseController
  handle_as_not_found GoogleAdword::Error::API::Keywords::InvalidKeywordId,
    error_code: GoogleAdword::Error::CODES[:invalid_keyword_id]
  handle_as_internal_server_error GoogleAdword::Error::API::Keywords::InvalidFile,
    error_code: GoogleAdword::Error::CODES[:invalid_file]

  before_action :load_keyword, only: :show
  before_action :load_keyword_params, only: :create

  def index
    keywords = @current_user.keywords.order_by_keyword.page(params[:page]).per 10
    presenters = KeywordsPresenter.new(keywords).as_json
    render json: {status: 0, keywords: presenters}
  end

  def show
    render json: {status: 0, keyword: {content: @keyword.content}}
  end

  def create
    @keywords.each{|k| CreateKeywordsJob.perform_later k}
    render json: {status: 0}
  end

  private
  def load_keyword
    @keyword = @current_user.keywords.find_by_id params[:id]
    return if @keyword
    raise GoogleAdword::Error::API::Keywords::InvalidKeywordId
  end

  def load_keyword_params
    @keywords = ParseKeywordsService.new(params[:keywords]).extract
    return if @keywords.present?
    raise GoogleAdword::Error::API::Keywords::InvalidFile
  end
end
