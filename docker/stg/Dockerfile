FROM node:11.13.0-stretch-slim as node
FROM ruby:2.6.3-slim-stretch

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -yqq \
        default-mysql-client-core \
        default-libmysqlclient-dev \
        imagemagick libmagickcore-dev libmagickwand-dev \
        build-essential \
        git \
        curl \
        openssh-client \
        gnupg \
        wget \
        apt-transport-https \
        jq \
        python3-pip \
        python3-setuptools \
        --no-install-recommends && \
        rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn

# Install the AWS CLI
RUN pip3 install --upgrade pip
RUN pip3 install awscli

COPY --from=node /usr/local/bin/node /usr/local/bin/

WORKDIR /qiitan

ARG RAILS_ENV=staging
ARG RACK_ENV=staging
ARG SECRET_KEY_BASE
ARG AWS_ACCESS_KEY_ID=''
ARG AWS_SECRET_ACCESS_KEY=''

COPY Gemfile .
COPY Gemfile.lock .
RUN cat Gemfile.lock | tail -1 | tr -d " " > BUNDLER_VERSION
RUN gem update --system && gem install bundler -v `cat BUNDLER_VERSION`
RUN bundle install --without test development local --jobs=4

COPY config/application.rb config/boot.rb config/environment.rb config/database.yml config/secrets.yml config/
COPY config/initializers/assets.rb config/initializers/
COPY config/environments/ config/environments/
COPY log/.keep log/
COPY bin/ bin/
COPY Rakefile .
COPY docker-entrypoint.sh .
COPY app/assets app/assets
COPY . .

ENTRYPOINT ["./docker-entrypoint.sh"]
RUN env RAILS_ENV=${RAILS_ENV} SECRET_KEY_BASE=${SECRET_KEY_BASE}  bundle exec rake assets:precompile
CMD ["bundle", "exec", "rails", "s", "puma", "-b", "0.0.0.0", "-p", "3000", "-e", "${RAILS_ENV}"]