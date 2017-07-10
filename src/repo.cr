require "yaml"

CONFIG = YAML.parse(File.read("./repo_config.yaml"))

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter  = Crecto::Adapters::Postgres
    conf.uri      = ENV["DATABASE_URL"]? || CONFIG["DATABASE_URL"].as_s
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
