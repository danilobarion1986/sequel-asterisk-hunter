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

      def fetch_rows(sql)
        hunt
        super
      end

      private

      def hunt
        AsteriskHunter.action&.call if sql.include?('SELECT *')
      end
    end
  end

  Dataset.register_extension(:asterisk_hunter, Extensions::AsteriskHunter)
end
