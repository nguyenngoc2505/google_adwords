module GoogleAdword
  class Auth
    def initialize login_info
      @login_info = login_info
    end

    def login!
      login_with_email!
    end

    private
    attr_reader :login_info

    def login_with_email!
      email = login_info[:user][:email]
      user = User.find_for_database_authentication email: email
      return invalid_login_email unless user
      if user.valid_password? login_info[:user][:password]
        return get_access_token(user.id)
      end
      invalid_login_email
    end

    def invalid_login_email
      raise GoogleAdword::Error::API::Login::InvalidEmailOrPassword
    end

    def get_access_token user_id
      if token = Session.find_by_user_id(user_id)
        token["token"]
      else
        Session.create user_id
      end
    end
  end
end
