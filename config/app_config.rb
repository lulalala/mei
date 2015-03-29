require 'settingslogic'
class AppConfig < Settingslogic
  source File.dirname(__FILE__) << "/app_config.yml"
end
