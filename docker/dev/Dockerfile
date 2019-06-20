FROM node:11.13.0-stretch-slim as node
FROM ruby:2.5.5-slim-stretch

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
        --no-install-recommends && \
        rm -rf /var/lib/apt/lists/*

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -yqq update && \
    apt-get -yqq install google-chrome-stable \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY --from=node /opt/yarn-v* /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

WORKDIR /app

COPY Gemfile.lock .
RUN gem update --system && gem install bundler -v $(cat Gemfile.lock | tail -1 | tr -d " ")