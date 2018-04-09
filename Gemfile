source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Base
gem 'bundler', '>= 1.8.4' #package manager
gem 'pg', '~> 0.18.2' #db
gem 'puma', '~> 3.11.2' #app server
gem 'rails', '~> 5.2' #mvc web framework

# CSS
gem 'sass-rails', '~> 5.0.7' #scss stylesheets

# JS
gem 'coffee-rails', '~> 4.2.2' #.coffee assets and views
gem 'uglifier', '>= 1.3.0' #JS asset compressor
gem 'jquery-rails', '~> 4.3.1' #use jquery as standard js library
gem 'jquery-rails-cdn', '~> 1.0.3' #cdn

# JSON
gem 'jbuilder', '~> 2.5' #generate JSON objects with a Builder-style DSL 
gem 'json', '~> 1.8.6' #json apis

# Cells
gem 'cells', '~> 3.11.3' #view components for Ruby and Rails
gem 'cells-collection', '~> 0.0.2' #cells rendering for a collection of items, utilizing cache bulk-read

# Misc
gem 'adequate_errors', '~> 0.1.1' #overcoming limitation of Rails model errors API 
gem 'auto_html', '~> 1.6.4' #a collection of filters that transforms plain text into HTML code
gem 'kaminari', '~> 1.1.1' #pagination
gem 'lulalala_presenter', "~> 0.1.0" #ActiveModel view presenter without excessive monkey-patching 
gem 'nilify_blanks', '~> 1.2.1' #save incoming blank values as nil in the database in instances where you'd rather use DB NULL than simply a blank string
gem 'settei', '~> 0.1.3' #12-factor env configuration with yml files
gem 'sitemap_generator', '~> 5.0.5' #generate sitemaps for seo
gem 'sucker_punch', '~> 2.0.1' #asynchronous processing library using concurrent-ruby
gem 'unobtrusive_flash', '~> 3.3.1' #turnkey Flash messages for your Rails app 

# Turbolinks
gem 'turbolinks' #dynamically load links and forms
gem 'jquery-turbolinks', '~> 2.1.0' #jQuery plugin for drop-in fix binded events problem caused by Turbolinks 

# DB seeding
gem 'seed-fu', '~> 2.3.6' #advanced seed data handling for Rails, combining the best practices of several methods together. 
gem 'seedbank', '~> 0.3' #gives your seed data a little structure. Create seeds for each environment, share seeds between environments and specify dependencies to load your seeds in order. All nicely integrated with simple rake tasks. 

# Image
gem 'carrierwave', '~> 0.10.0' #file uploads
gem 'fastimage', '~> 1.7.0' #finds the size or type of an image given its uri by fetching as little as needed
gem 'mini_magick', '~> 4.2.7' #mini replacement for RMagick 

# Assets
source 'https://rails-assets.org' do
  gem 'rails-assets-js-cookie' #simple, lightweight JavaScript API for handling cookies
  gem 'rails-assets-normalize.css', '~> 3.0.3' #an alternative to CSS resets 
  gem 'rails-assets-blueimp-file-upload', '~> 9.12.1' #file Upload widget with multiple file selection, drag&drop support, progress bar, validation and preview images, audio and video for jQuery
end

group :development do
  gem 'web-console', '>= 3.3.0' #access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2' #listens to file modifications and notifies you about the changes.
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] #call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'capybara', '~> 2.13' #Capybara system testing and selenium driver
  gem 'pry' #debugger
  gem 'selenium-webdriver' #browser automation framework and ecosystem
  gem 'spring' #speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails', '~> 4.8.2' #fixtures replacement
  gem 'guard-rspec', '~> 4.7' #allows to automatically & intelligently launch specs when files are modified
  gem 'rspec-rails', '~> 3.7' #rspec for rails
  gem 'spring-commands-rspec', '~> 1.0.4' #implements the rspec command for Spring
  gem 'timecop', '~> 0.9.1' #freeze time in specs
end

group :doc do
  gem 'sdoc', '~> 0.4.2' #standalone sdoc generator
end

group :darwin do
  gem 'rb-fsevent', '~> 0.10.2' #Mac OSX FSEvents API, only needed for MacOS below 10.12
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] #Windows does not include zoneinfo files, so bundle the tzinfo-data gem