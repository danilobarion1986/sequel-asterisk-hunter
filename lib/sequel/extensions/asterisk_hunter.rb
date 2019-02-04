# frozen_string_literal: true

require 'sequel'

# no-doc
module Sequel
  # no-doc
  module Extensions
    # no-doc
    module AsteriskHunter
      class << self
        attr_accessor :action

        def define_action(user_action)
          raise TypeError, 'Action parameter must be a callable object!' unless user_action.respond_to?(:call)

          AsteriskHunter.action = user_action
        end
      end

      # Default action if user don't define any.
      class DefaultAction
        def self.call; end

        def call; end
      end

      def fetch_rows(sql)
        hunt(sql)
        super
      end

      private

      def hunt(sql)
        AsteriskHunter.action&.call || AsteriskHunter::DefaultAction if sql.include?('SELECT *')
      end
    end
  end

  Dataset.register_extension(:asterisk_hunter, Extensions::AsteriskHunter)
end
