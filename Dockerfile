FROM ruby:2.5
MAINTAINER sztheory

ENV PHANTOM_VERSION=2.1.1

RUN apt-get update && apt-get install -y \
    # capybara + launchy
    iceweasel \
    # rails asset pipeline
    nodejs \
    # Download phantomjs, needed for Poltergeist capybara driver
    && cd /tmp \
    && curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOM_VERSION}-linux-x86_64.tar.bz2 \
    && tar xvjf phantomjs-${PHANTOM_VERSION}-linux-x86_64.tar.bz2 \
    && cp /tmp/phantomjs-*/bin/phantomjs /usr/local/bin/phantomjs

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