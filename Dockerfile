FROM ruby:3.0.2

WORKDIR /app

ADD . /app

RUN bundle install

CMD ["ruby", "check.rb"]