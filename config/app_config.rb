require 'settingslogic'
class AppConfig < Settingslogic
  source File.dirname(__FILE__) << "/app_config.yml"

  # returns domain string
  # pass in false for segment key to hide that segment, e.g. `protocol:false`
  def self.domain(params = {})
    default_params = self.get('domain_setting').to_hash
    params = default_params.merge(params)

    url = ''
    url << params[:protocol].clone << '://' if params[:protocol]
    url << params[:subdomain].clone << '.' if params[:subdomain]
    url << params[:domain]
    url << ':' << params[:port].to_s if params[:port]
    url
  end
end
