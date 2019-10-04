FROM ruby:2.6.4-slim

RUN apt-get update && apt-get install -y curl \
  git \
  gnupg \
  g++ \
  libnotify4 \
  default-libmysqlclient-dev \
  cmake \
  pkg-config

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler --no-document -f && bundle install --jobs 4 --retry 3

RUN yarn install --check-files

COPY . ./
