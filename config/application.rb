require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Newfarmer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # 以下の行をバッチ処理のため追加　2021/06/16
    config.paths.add 'lib', eager_load: true
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
