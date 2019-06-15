FROM ruby:2.5.1-alpine

ENV LANG ja_JP.UTF-8
ENV PAGER busybox less

RUN apk update && \
    apk upgrade && \
    apk add --update\
    bash \
    build-base \
    curl-dev \
    git \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    mysql-dev \
    nodejs \
    openssh \
    ruby-dev \
    ruby-json \
    tzdata \
    yaml \
    yaml-dev \
    zlib-dev \
    imagemagick \
    jq \
    python3 \
    python3-dev

# Install the AWS CLI
RUN pip3 install --upgrade pip
RUN pip3 install awscli

RUN gem install bundler
RUN gem update

ARG RAILS_ENV=staging
ARG RACK_ENV=staging
ARG SECRET_KEY_BASE
ARG AWS_ACCESS_KEY_ID=''
ARG AWS_SECRET_ACCESS_KEY=''

ENV APP_HOME /qiitan
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV GEM_HOME=/bundle

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=$GEM_HOME

RUN bundle config build.nokogiri --use-system-libraries && \
    bundle config build.mysql2 --use-system-libraries && \
    bundle install --jobs 20 --retry 5

ADD . $APP_HOME

EXPOSE 3000

RUN npm install
ENTRYPOINT ["source ./docker-entrypoint.sh"]
RUN env RAILS_ENV=${RAILS_ENV} SECRET_KEY_BASE=${SECRET_KEY_BASE}  bundle exec rake assets:precompile
CMD ["bundle", "exec", "rails", "s", "puma", "-b", "0.0.0.0", "-p", "3000", "-e", "${RAILS_ENV}"]