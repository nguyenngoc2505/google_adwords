class Api::ImportKeywordsController < Api::BaseController
  INVALID_FILE = GoogleAdword::Error::API::Keywords::InvalidFile
  INVALID_USER = GoogleAdword::Error::API::Keywords::InvalidUserId

  handle_as_internal_server_error INVALID_FILE,
    error_code: GoogleAdword::Error::CODES[:invalid_file]
  handle_as_internal_server_error INVALID_USER,
    error_code: GoogleAdword::Error::CODES[:invalid_user_id]

  def create
    @import_keyword = ImportKeyword.new import_keyword_params
    if @import_keyword.save
      render json: {status: 0}
    else
      raise_errors
    end
  end

  private
  def import_keyword_params
    keywords_params = params.require(:import_keyword).permit!
    keywords_params.merge user_id: current_user.id
  end

  def raise_errors
    raise(INVALID_USER) if @import_keyword.errors.messages.key?(:user_id)
    raise INVALID_FILE
  end
end
