module GoogleAdword::Error
  CODES = {
    invalid_email_or_password: 11,
    invalid_params: 12,
    invalid_access_token: 13,
    no_access_token: 14,
    invalid_keyword_id: 15,
    invalid_file: 16,
    invalid_user_id: 17
  }
  class Base < RuntimeError
    def initialize message_hash = {}
      t_key = self.class.name.underscore.gsub(/\//, ".")
      super I18n.t(t_key, message_hash)
    end
  end
  module API
    module Common
      class NoAccessToken < GoogleAdword::Error::Base; end
      class InvalidAccessToken < GoogleAdword::Error::Base; end
    end

    module Login
      class InvalidEmailOrPassword < GoogleAdword::Error::Base; end
      class InvalidParams < GoogleAdword::Error::Base; end
    end

    module Keywords
      class InvalidKeywordId < GoogleAdword::Error::Base; end
      class InvalidFile < GoogleAdword::Error::Base; end
      class InvalidUserId < GoogleAdword::Error::Base; end
    end
  end
end
