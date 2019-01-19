FROM ruby:2.5.1
ENV HOME /qiitan
WORKDIR $HOME

ADD Gemfile      $HOME/Gemfile
ADD Gemfile.lock $HOME/Gemfile.lock

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim

RUN bundle install -j4

ADD . $HOME

CMD ["rails", "server", "-b", "0.0.0.0"]