class Session
  DB = 0
  SESSION_LIFETIME = 1.day
  UID_KEY_PREFIX = "session::uid::"
  TOKEN_KEY_PREFIX = "session::token::"

  class << self
    def find_by_user_id user_id
      token = redis.get uid_key(user_id)
      JSON.parse token if token
    end

    def find_by_token token
      redis.get token_key(token)
    end

    def create user_id
      token = generate_access_token
      save_with user_id, token
      token
    end

    private
    def redis
      @redis ||= GoogleAdword::RedisConnector.new DB
    end

    def save_with user_id, token, ttl = SESSION_LIFETIME
      redis.multi
      redis.setex uid_key(user_id), ttl, {token: token}.to_json
      redis.setex token_key(token), ttl, user_id
      redis.exec
    end

    def uid_key user_id
      UID_KEY_PREFIX + user_id.to_s
    end

    def token_key token
      TOKEN_KEY_PREFIX + token.to_s
    end

    def generate_access_token
      GoogleAdword::Token.generate
    end
  end
end
