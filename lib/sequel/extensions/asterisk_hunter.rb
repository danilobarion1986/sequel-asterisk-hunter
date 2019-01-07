# frozen_string_literal: true

require 'sequel'

module Sequel
  module Extensions
    module AsteriskHunter
      class << self
        attr_accessor :user_action

        def action=(user_action)
          raise TypeError, 'Action parameter must be a callable object!' unless user_action.respond_to?(:call)
          AsteriskHunter.user_action = user_action
        end
      end

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
        AsteriskHunter.user_action&.call || AsteriskHunter::DefaultAction.call if execute_action?
      end

      def execute_action?
        sql.include?('SELECT *')
      end
    end
  end

  Dataset.register_extension(:asterisk_hunter, Extensions::AsteriskHunter)
end
