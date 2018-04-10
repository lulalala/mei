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

# Copy the main application.
COPY . $APP_DIR

# Set the Bundler path so we can cache it in local volume for dev
ENV BUNDLE_PATH /bundle