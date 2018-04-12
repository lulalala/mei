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

# Add app files into docker image
ENV APP_DIR /app
RUN mkdir $APP_DIR
WORKDIR $APP_DIR
COPY . .

# Add bundle entry point to handle bundle cache
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Set the Bundler path so we can cache it in local volume for dev
# Bundle installs with binstubs to our custom /bundle/bin volume path. 
# Let system use those stubs.
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"