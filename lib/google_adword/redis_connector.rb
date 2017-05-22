module GoogleAdword
  class RedisConnector < ::Redis
    REDIS_CONFIG = YAML.load_file(::Rails.root.join "config/database.yml")

    def initialize db = 0
      options = if ::Rails.env.development?
        {host: REDIS_CONFIG[::Rails.env]["redis"]["host"], db: db}
      else
        {db: db}
      end
      super options
    end
  end
end
