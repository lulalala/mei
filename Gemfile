# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Base
gem 'bootsnap', require: false # reduce Rails boot time
gem 'bundler', '>= 1.8.4' # package manager
gem 'pg', '~> 0.18.2' # db
gem 'puma', '~> 3.11.2' # app server
gem 'rails', '~> 5.2' # mvc web framework

# CSS
gem 'sass-rails', '~> 5.0.7' # scss stylesheets

# JS
gem 'coffee-rails', '~> 4.2.2' # .coffee assets and views
gem 'jquery-rails', '~> 4.3.1' # use jquery as standard js library
gem 'jquery-rails-cdn', '~> 1.0.3' # cdn
gem 'uglifier', '>= 1.3.0' # JS asset compressor

# JSON
gem 'jbuilder', '~> 2.5' # generate JSON objects with a Builder-style DSL
gem 'json', '~> 1.8.6' # json apis

# Cells
gem 'cells', '~> 3.11.3' # view components for Ruby and Rails
# cells rendering for a collection of items, utilizing cache bulk-read
gem 'cells-collection', '~> 0.0.2'

# Misc
# overcoming limitation of Rails model errors API
gem 'adequate_errors', '~> 0.1.1'
# a collection of filters that transforms plain text into HTML code
gem 'auto_html', '~> 1.6.4'
gem 'kaminari', '~> 1.1.1' # pagination
# ActiveModel view presenter without excessive monkey-patching
gem 'lulalala_presenter', '~> 0.1.0'
# save incoming blank values as nil in the database in instances
# where you'd rather use DB NULL than simply a blank string
gem 'nilify_blanks', '~> 1.2.1'
gem 'settei', '~> 0.1.3' # 12-factor env configuration with yml files
gem 'sitemap_generator', '~> 5.0.5' # generate sitemaps for seo
# asynchronous processing library using concurrent-ruby
gem 'sucker_punch', '~> 2.0.1'
# turnkey Flash messages for your Rails app
gem 'unobtrusive_flash', '~> 3.3.1'

# Turbolinks
# jQuery plugin for drop-in fix binded events problem caused by Turbolinks
gem 'jquery-turbolinks', '~> 2.1.0'
gem 'turbolinks' # dynamically load links and forms

# DB seeding
# advanced seed data handling for Rails, combining the
# best practices of several methods together.
gem 'seed-fu', '~> 2.3.6'
# gives your seed data a little structure. Create seeds for each environment,
# share seeds between environments and specify dependencies to load your
# seeds in order. All nicely integrated with simple rake tasks.
gem 'seedbank', '~> 0.3'

# Image
gem 'carrierwave', '~> 0.10.0' # file uploads
# finds the size or type of an image given its uri by fetching as little as needed
gem 'fastimage', '~> 1.7.0'
gem 'mini_magick', '~> 4.2.7' # mini replacement for RMagick

# Assets
source 'https://rails-assets.org' do
  # file Upload widget with multiple file selection, drag&drop support,
  # progress bar, validation and preview images, audio and video for jQuery
  gem 'rails-assets-blueimp-file-upload', '~> 9.12.1'
  # simple, lightweight JavaScript API for handling cookies
  gem 'rails-assets-js-cookie'
  gem 'rails-assets-normalize.css', '~> 3.0.3' # an alternative to CSS resets
end

group :development do
  # listens to file modifications and notifies you about the changes.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # access an IRB console on exception pages or by
  # using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  # call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13' # Capybara system testing and selenium driver
  gem 'poltergeist'
  gem 'pry' # debugger
  gem 'selenium-webdriver' # browser automation framework and ecosystem
  # speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails', '~> 4.8.2' # fixtures replacement
  # allows to automatically & intelligently launch specs when files are modified
  gem 'guard-rspec', '~> 4.7'
  gem 'launchy' # save_and_open_page for system specs
  gem 'rspec-rails', '~> 3.7' # rspec for rails
  gem 'spring-commands-rspec', '~> 1.0.4' # implements the rspec command for Spring
  gem 'timecop', '~> 0.9.1' # freeze time in specs
end

group :doc do
  gem 'sdoc', '~> 0.4.2' # standalone sdoc generator
end

group :darwin do
  # Mac OSX FSEvents API, only needed for MacOS below 10.12
  gem 'rb-fsevent', '~> 0.10.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
