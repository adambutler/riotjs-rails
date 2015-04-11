require "tilt"
require "execjs"
require "riotjs-rails/javascript_compiler"

module Riot
  module Rails
    class Template < Tilt::Template

      self.default_mime_type = 'application/javascript'

      def evaluate(context, locals, &block)
        Riot::Rails::JavascriptCompiler.new.compile(data)
      end

      # noop method needed for not raise NotImplementedError
      def prepare
      end
    end
  end
end
