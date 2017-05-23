source 'https://rubygems.org'

gem 'bundler', '>= 1.8.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# database
gem 'pg', '~> 0.18.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3.1'
gem 'jquery-rails-cdn', '~> 1.0.3'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks', '~> 2.1.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'puma', '~> 3.4.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'cells', '~> 3.11.3'
gem 'cells-collection', '~> 0.0.2'
gem 'kaminari', '~> 0.16'
gem 'auto_html', '~> 1.6.4'
gem 'lulalala_presenter', "~> 0.0.1"

gem 'squeel', '~> 1.2'
gem 'nilify_blanks', '~> 1.2.1'

gem 'migration_comments', '~> 0.3'
gem 'seed-fu', '~> 2.3.5'
gem 'seedbank', '~> 0.3'

gem 'quiet_assets', '~> 1.1'

gem 'settingslogic', '~> 2.0'

gem 'unobtrusive_flash', '~> 3.1.0'

gem 'sitemap_generator', '~> 5.0.5'

# Image
gem 'mini_magick', '~> 4.2.7'
gem 'carrierwave', '~> 0.10.0'
gem 'fastimage', '~> 1.7.0'

# Assets
source 'https://rails-assets.org' do
  gem 'rails-assets-js-cookie'
  gem 'rails-assets-normalize.css', '~> 3.0.3'
  gem 'rails-assets-blueimp-file-upload', '~> 9.12.1'
end

gem 'sucker_punch', '~> 2.0.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.6'

  gem 'mysql2', '~> 0.3.18' # Sequel Pro is too good that I can't escape MySQL
end

group :test, :darwin do
  gem 'rspec-rails', '~> 3.4.2'
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'guard-rspec', '~> 4.6.5'
  gem 'rb-fsevent', '~> 0.9.7'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'timecop', '~> 0.8.1'
end

