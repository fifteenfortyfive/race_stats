module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::Postgres # or Crecto::Adapters::Mysql or Crecto::Adapters::SQLite3
    conf.database = "fifteenfortyfive"
    conf.hostname = "localhost"
    conf.username = "race_admin"
    conf.password = ""
    conf.port = 5432
    # you can also set initial_pool_size, max_pool_size, max_idle_pool_size,
    #  checkout_timeout, retry_attempts, and retry_delay
  end

end

Query = Crecto::Repo::Query
Crecto::DbLogger.set_handler(STDOUT)
