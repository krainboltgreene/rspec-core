require 'rspec/core/formatters/base_text_formatter'
module RSpec
  module Core
    module Formatters

      class ProgressFormatter < BaseTextFormatter

        def example_passed(notification)
          super
          output.print success_color('.')
        end

        def example_pending(notification)
          super
          output.print pending_color('*')
        end

        def example_failed(notification)
          super
          output.print failure_color('F')
        end

        def start_dump(notification)
          super
          output.puts
        end

      end

    end
  end
end
