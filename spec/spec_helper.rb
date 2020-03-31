# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'sequel-asterisk-hunter'
require 'pry'
require 'sequel/adapters/mock'

Dir['./spec/support/*'].each(&method(:require))

RSpec.configure do |config|
  config.mock_framework = :rspec
end
