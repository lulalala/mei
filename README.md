# Imageboard Mei [![Build Status](https://travis-ci.org/szTheory/mei.svg?branch=master)](https://travis-ci.org/szTheory/mei)

Mei is a Futaba-styled imageboard, allowing people to discuss and upload pictures. My aim is to improve the user interface to my liking, instead of mimicking the traditional Futaba's look & feel.

**Visit the [wiki](https://github.com/lulalala/mei/wiki) to see more information! I try to minimize number of commits so documentations are all over there!**

## Highlights

* Multi-image upload
* Image upload using url
* Better user interface
* Multi-board support
* Extensible

## Docker
First run:
    cp config/database.yml.example config/database.yml
    cp docker-compose.yml.example docker-compose.yml
    docker-compose up -d #-d for daemon mode in the background
    docker-compose exec app rake db:create
    docker-compose exec app rake db:migrate
    docker-compose exec app rake db:seed
Then visit `localhost:3000/i` in your browser.

To stop the server:
  docker-compose stop

To run the specs:
    docker-compose exec app rspec

Here are a couple example aliases you might find useful to avoid repetitive typing (place in `~/.bash_profile` or `~/.zshrc`)
    alias d="docker-compose exec app " #note this includes `bundle exec` by default from the Dockerfile's `ENTRYPOINT`
    alias dc="docker-compose "