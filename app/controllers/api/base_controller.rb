class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :require_access_token

  include GoogleAdword::ErrorHandling

  handle_as_internal_server_error GoogleAdword::Error::API::Common::NoAccessToken,
    error_code: GoogleAdword::Error::CODES[:no_access_token]
  handle_as_forbidden GoogleAdword::Error::API::Common::InvalidAccessToken,
    error_code: GoogleAdword::Error::CODES[:invalid_access_token]

  private
  def require_access_token
    unless access_token = params[:access_token].presence
      raise GoogleAdword::Error::API::Common::NoAccessToken
    end
    user_id = Session.find_by_token access_token
    raise GoogleAdword::Error::API::Common::InvalidAccessToken unless user_id
    @current_user = User.find_by_id user_id
  end
end
