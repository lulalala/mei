require 'settei/loaders/simple_loader'
require 'settei/base'
require 'settei/extensions/host_url'

loader = Settei::Loaders::SimpleLoader.new(
  dir: File.join(File.dirname(__FILE__), "environments"),
  env_name: '' #blank string to force settei uses default.yml instead of development.yml so we can build on Travis CI
)
loader.load
Setting = Settei::Base.new(loader.as_hash)
Setting.extend Settei::Extensions::HostUrl
