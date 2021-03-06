require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OmoApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # don't generate RSpec tests for views and helpers
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    # config/initializers/locale.rb
    # Where the I18n library should search for translation files
    I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    # Whitelist locales available for the application
    I18n.available_locales = %i[en fr]
    # Set default locale to something other than :en
    I18n.default_locale = :fr

    config.active_job.queue_adapter = :sidekiq
  end
end
