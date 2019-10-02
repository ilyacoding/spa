FROM ruby:2.6.4-slim

ENV LANG C.UTF-8
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

RUN apt-get update && apt-get install -y curl \
  git \
  gnupg \
  default-libmysqlclient-dev \
  cmake \
  pkg-config \
  g++

ENV NODE_VERSION 8

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs \
  yarn \
  libnotify4

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler --no-document -f && bundle install --jobs 4 --retry 3

RUN yarn install --check-files

COPY . ./
