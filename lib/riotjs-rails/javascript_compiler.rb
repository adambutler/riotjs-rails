require "action_view"

module Riot
  module Rails
    class JavascriptCompiler
      include ::ActionView::Helpers::JavaScriptHelper

      RUNTIME = ::ExecJS::ExternalRuntime.new(
        name: 'Node.js (V8)',
        command: ['nodejs', 'node'],
        encoding: 'UTF-8',
        runner_path: File.expand_path('../../support/riot_node_runner.js', __FILE__),
      )

      COMPILER_PATH = File.expand_path('../../support/riot_compiler.js', __FILE__)

      def compile(source_code)
        source_code = escape_javascript(source_code)
        source_code = wrap_in_javascript_compiler(source_code)
        RUNTIME.exec(source_code)
      end

      private
        def wrap_in_javascript_compiler(source_code)
          <<-JS
            var compiler = require("#{COMPILER_PATH}");
            return compiler.compile("#{source_code}");
          JS
        end
    end
  end
end
