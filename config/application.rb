require File.expand_path('../boot', __FILE__)


require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"


Bundler.require(:default, Rails.env) if defined?(Bundler)

module TimelineMaker
  class Application < Rails::Application
  
    config.action_view.javascript_expansions[:defaults] = %w(jquery/jquery.min jquery/jquery.metadata rails)

    config.generators do |generator|
      generator.fixture_replacement :machinist
      generator.test_framework :rspec, :views => false
      generator.orm :mongoid
    end

   config.encoding = "utf-8"

    config.filter_parameters += [:password]
  end
end
