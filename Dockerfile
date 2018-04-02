FROM sztheory/rubynode:2.5.1_8.11.0

RUN apk add --no-cache \
    bash \
    binutils-gold \
    curl \
    g++ \
    gcc \
    imagemagick \
    libressl-dev \
    libssl1.0 \
    libxml2-dev \
    libxslt-dev \
    make \
    postgresql-dev \
    readline-dev \
    tzdata && \
  mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install

ADD . /usr/src/app

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
