class Api::SessionsController < DeviseController
  protect_from_forgery with: :null_session

  include GoogleAdword::ErrorHandling

  handle_as_not_found GoogleAdword::Error::API::Login::InvalidEmailOrPassword,
    error_code: GoogleAdword::Error::CODES[:invalid_email_or_password]
  handle_as_internal_server_error GoogleAdword::Error::API::Login::InvalidParams,
    error_code: GoogleAdword::Error::CODES[:invalid_params]
  handle_as_not_found GoogleAdword::Error::API::Login::UserNotRegister,
    error_code: GoogleAdword::Error::CODES[:user_not_register]

  prepend_before_action :require_no_authentication, only: :create
  before_action :ensure_params_exist

  def create
    access_token = GoogleAdword::Auth.new(request_info).login!
    render json: {status: 0, access_token: access_token}
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
