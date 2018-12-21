# frozen_string_literal: true

require "sequel"

module Sequel
  module Extensions
    module AsteriskHunter
      def hunt(action: :log)
        return 'Find it!' if self.inspect.include?('SELECT *')
        self
      end
    end
  end

  Dataset.register_extension(:hunt, Extensions::AsteriskHunter)
end
