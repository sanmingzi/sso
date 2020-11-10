require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sso
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Override the html when validation failed
    # @@field_error_proc = Proc.new{ |html_tag, instance| 
    #   "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe
    # }
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html_tag
    }
  end
end
