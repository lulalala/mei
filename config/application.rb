require_relative 'app_config'

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mei
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_dispatch.default_headers = {
      'X-XSS-Protection' => '1; mode=block',
      'X-Content-Type-Options' => 'nosniff'
    }

    config.active_job.queue_adapter = :sucker_punch
  end
end
