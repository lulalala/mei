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

Requires `docker` and `docker-compose` installed on your box.

**First run:**

    cp config/database.yml.example config/database.yml

    cp config/environments/default.yml.example config/environments/default.yml

    docker-compose run --rm app bundle install --jobs 3

    docker-compose up -d
    
    docker-compose exec app bundle exec rake db:create 

    docker-compose exec app bundle exec rake db:migrate

    docker-compose exec app bundle exec rake db:seed

Then visit `localhost:3000/i` in your browser.

**Start server:**

    docker-compose up -d #-d for daemon mode in the background

**Stop server:**

    docker-compose stop

**Run specs:**

    docker-compose build app

    docker-compose up -d

    docker-compose exec app bundle exec rspec

**Useful aliases to avoid repetitive typing (place in `~/.bash_profile` or `~/.zshrc`):**

    # NOTE: this includes `bundle exec` by default from the Dockerfile's `ENTRYPOINT`
    alias d="docker-compose exec app " 

    alias dc="docker-compose "

## Managing your board data

Boot into the Rails console with `rails c`. Then you can run commands such as:

`Topic.destroy_all` clear out the default topic its nested posts

`Post.destroy_all` clear all posts, across all boards

`Post.find(idhere).destroy` delete a post

`Topic.find(idhere).destroy` delete a topic and all of its nested posts

`Post.find(idhere).update_attribute(:content_html, "<p>I didn't say that!</p>")` update a specific post

`Board.find_by_seo_name("i").topics.destroy_all` clear all topics/posts on the specified board

`Board.all` list all boards, including the default /i/

`Board.first.update_attributes(seo_name: "b", name: "Random")` updates the default board info

`Board.create(seo_name: "a", name: "Anime")` creates a new board

## Customization

You can replace `app/views/application/index.html` with whatever you want in order to change the home page. You can also edit/replace partials in `app/views/partials/_global` for `_bottom_of_footer.erb`, `_bottom_of_head.erb`, `_top_of_header.erb`, and `_after_form.erb` to customize the global content. To override these settings on a per-board basis, create a corresponding version for your board name. For example to override the global footer with one specific to /i/ you'd create a `app/views/partials/i/_bottom_of_footer.erb`

### Partials

`bottom_of_head` placed at the bottom of <head> to insert custom javascipt/css

`top_of_header` top nav bar

`bottom_of_footer` footer content

`after_form` content underneath the post form such as news or board rules