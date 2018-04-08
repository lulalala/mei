# Ruby + Node are necessary for a Rails app (Node is needed for asset pipeline)
FROM sztheory/rubynode:2.5.1_8.11.0
MAINTAINER sztheory

# Install apt based dependencies required to run Rails as well as RubyGems and any other gem deps.
# As the Ruby image itself is based on an Alpine image, we use apk to install those
RUN apk add --no-cache \
    bash \
    binutils-gold \
    curl \
    g++ \
    gcc \
    imagemagick \
    make \
    libressl-dev \
    libssl1.0 \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    readline-dev \
    tzdata

ENV APP_DIR /app

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT commands
RUN mkdir $APP_DIR
WORKDIR $APP_DIR

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files are made
COPY Gemfile $APP_DIR
COPY Gemfile.lock $APP_DIR
# optimal bundler job count is 1 less than the number of cores in your machine
# source: https://robots.thoughtbot.com/parallel-gem-installing-using-bundler#fn-2013-08-27-2
ENV BUNDLER_NUM_JOBS 3
ENV BUNDLER_RETRY_COUNT 5
RUN bundle install --jobs $BUNDLER_NUM_JOBS --retry $BUNDLER_RETRY_COUNT

# Copy the main application.
COPY . $APP_DIR