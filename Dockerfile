# TODO: mount this for development/test envs

# Ruby + Node are necessary for a Rails app (Node is needed for asset pipeline)
FROM sztheory/rubynode:2.5.1_8.11.0

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

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT commands
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files are made
COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle install

# Copy the main application.
COPY . /app