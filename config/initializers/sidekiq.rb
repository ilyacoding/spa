# frozen_string_literal: true

schedule_file = "config/schedule.yml"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file))
