require 'tilt'
require 'execjs'

module Riot
  module Rails
    class Template < Tilt::Template

      self.default_mime_type = 'application/javascript'

      def evaluate(context, locals, &block)
        source_code = wrap_new_lines(data)
        source_code = escape_quotes(source_code)
        runtime.exec(compile_riotjs(source_code))
      end

      # noop method needed for not raise NotImplementedError
      def prepare
      end

      private
        def compile_riotjs(source_code)
          compiler_path = File.expand_path('../../support/riot_compiler.js', __FILE__)
          <<-JS
          var compiler = require("#{compiler_path}");
          return compiler.compile("#{source_code}");
          JS
        end

        def wrap_new_lines(source_code)
          source_code.gsub("\n", "\\n")
        end

        def escape_quotes(source_code)
          source_code.gsub('"', '\"')
        end

        def runtime
          @runtime ||= ::ExecJS::ExternalRuntime.new(
            name: 'Node.js (V8)',
            command: ['nodejs', 'node'],
            encoding: 'UTF-8',
            runner_path: File.expand_path('../../support/riot_node_runner.js', __FILE__),
          )
        end
    end
  end
end
