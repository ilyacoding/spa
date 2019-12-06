# frozen_string_literal: true

source "https://rubygems.org"

gem "bootsnap", ">= 1.4.2", require: false
gem "clickhouse-rails"
gem "faraday"
gem "jbuilder", "~> 2.7"
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 3.12"
gem "rails", "~> 5.2.3"
gem "rotp"
gem "sidekiq"
gem "sidekiq-cron"
gem "webpacker", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "pry-byebug"
  gem "rake"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", "0.75.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end
