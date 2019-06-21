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
        wget \
        --no-install-recommends && \
        rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y unzip && \
    CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    chown root:root ~/chromedriver && \
    chmod 755 ~/chromedriver && \
    mv ~/chromedriver /usr/bin/chromedriver && \
    curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -yqq update && \
    apt-get -yqq install google-chrome-stable \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY --from=node /usr/local/bin/node /usr/local/bin/

WORKDIR /qiitan

COPY Gemfile.lock .
RUN gem update --system && gem install bundler -v $(cat Gemfile.lock | tail -1 | tr -d " ")