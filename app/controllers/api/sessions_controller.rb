class Api::SessionsController < DeviseController
  protect_from_forgery with: :null_session
  EMAIL_PASSWORD = GoogleAdword::Error::API::Login::InvalidEmailOrPassword
  INVALID_PARAMS = GoogleAdword::Error::API::Login::InvalidParams
  NO_ACCESS_TOKEN = GoogleAdword::Error::API::Common::NoAccessToken

  include GoogleAdword::ErrorHandling

  handle_as_not_found EMAIL_PASSWORD,
    error_code: GoogleAdword::Error::CODES[:invalid_email_or_password]
  handle_as_internal_server_error INVALID_PARAMS,
    error_code: GoogleAdword::Error::CODES[:invalid_params]
  handle_as_internal_server_error NO_ACCESS_TOKEN,
    error_code: GoogleAdword::Error::CODES[:no_access_token]

  prepend_before_action :require_no_authentication, only: :create
  before_action :ensure_params_exist, only: :create

  def create
    access_token = GoogleAdword::Auth.new(request_info).login!
    render json: {status: 0, access_token: access_token}
  end

  def destroy
    unless access_token = params[:access_token].presence
      raise GoogleAdword::Error::API::Common::NoAccessToken
    end
    Session.destroy_by_token access_token
    render json: {status: 0}
  end

  private
  def ensure_params_exist
    return if valid_params?
    raise GoogleAdword::Error::API::Login::InvalidParams
  end

  def valid_params?
    params[:user].present?
  end

  def request_info
    params.require(:session).permit!
  end
end
