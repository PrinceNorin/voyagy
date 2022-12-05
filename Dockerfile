FROM ruby:2.7.1

RUN apt-get update

WORKDIR /app

ADD Gemfile Gemfile.lock ./
RUN bundle install

ADD . .

EXPOSE 3000
ENTRYPOINT ["./entrypoint.sh"]
