# frozen_string_literal: true

require "sequel"

module Sequel
  module Extensions
    module AsteriskHunter
      @@action = -> { puts "Find 'SELECT *' in query!" }

      def all
        hunt
        super
      end

      def self.define_action(action)
        raise TypeError, 'Action parameter must be a callable object!' unless action.respond_to?(:call)
        @@action = action
      end

      private

      def hunt
        @@action.call if self.inspect.include?('SELECT *')
        self
      end
    end
  end

  Dataset.register_extension(:asterisk_hunter, Extensions::AsteriskHunter)
end
