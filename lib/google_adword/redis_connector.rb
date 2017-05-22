class GoogleAdword::RedisConnector < Redis
  REDIS_CONFIG = YAML.load_file(::Rails.root.join "config/database.yml")

  def initialize db = 0
    super host: REDIS_CONFIG[::Rails.env]["redis"]["host"], db: db
  end
end
