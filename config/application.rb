require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
Bundler.require(*Rails.groups)

module Tranker
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators.template_engine = :slim
    config.generators.system_tests = nil
    config.generators do |g|
      # CSS、JSファイル作成しない
      g.assets false
      # routes.rb変更しない
      g.skip_routes false
      # ヘルパーを作成しない
      g.helper false
      # testを作成しない
      g.test_framework false
    end
  end
end
