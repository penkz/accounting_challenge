FROM ruby:2.6.5

RUN apt-get update -y
RUN apt-get install -y build-essential default-libmysqlclient-dev nodejs
RUN mkdir /accounting-challenge
WORKDIR /accounting-challenge
RUN gem install bundler
COPY Gemfile /accounting-challenge/Gemfile
COPY Gemfile.lock /accounting-challenge/Gemfile.lock
RUN bundle install
COPY . /accounting-challenge
