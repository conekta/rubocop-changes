FROM ruby:3.0.3-slim

RUN apt-get update && \
    apt-get install build-essential libxml2-dev curl git ssh --no-install-recommends -y
RUN mkdir /app
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN gem install bundler

WORKDIR /app

COPY . /app

RUN bundler --version
RUN --mount=type=ssh git config --global url."ssh://git@github.com/conekta".insteadOf "https://github.com/conekta" \
      && bundle update --bundler \
      && bundle install -j 4
