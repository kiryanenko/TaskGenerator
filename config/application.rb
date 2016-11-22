require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaskGenerator
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.wolfram_api = 'UUHYPG-WUPR2YEXLQ'
    config.page_layouts = [['', 0], ['Билет на отдельной странице', 1]]
    config.max_variants = 200   # Максимальное количество генерируемых вариантов
  end
end
