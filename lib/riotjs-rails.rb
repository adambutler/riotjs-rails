require "riotjs-rails/version"
require "riotjs-rails/template"

module Riot
  module Rails
    if defined?(::Rails) and Gem::Requirement.new('>= 3.1').satisfied_by?(Gem::Version.new ::Rails.version)
      class Rails::Engine < ::Rails::Engine

        initializer :setup_riotjs do |app|
          app.assets.register_engine '.tag', Riot::Rails::Template
        end

      end
    end
  end
end
