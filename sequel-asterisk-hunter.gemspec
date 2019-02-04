# frozen_string_literal: true

begin
  require './lib/sequel-asterisk-hunter/version'
rescue LoadError
  module SequelAsteriskHunter; VERSION = '0'; end
end

Gem::Specification.new do |spec|
  spec.name          = 'sequel-asterisk-hunter'
  spec.version       = SequelAsteriskHunter::VERSION
  spec.authors       = ['Danilo Barion Nogueira']
  spec.email         = 'danilo.barion@gmail.com'
  spec.summary       = "Sequel extension which allow you to do some action when find any 'SELECT *' queries."
  spec.description   = 'This extension hooks into `Sequel::Dataset#all` method, doing some predefined action when an `SELECT *` statement is found.'
  spec.homepage      = 'https://github.com/danilobarion1986/sequel-asterisk-hunter'
  spec.license       = 'MIT'
  spec.required_ruby_version = '~> 2.5'

  spec.require_paths = ['lib']
  spec.files         = Dir.glob('{bin,lib}/**/*') + \
                       %w[LICENSE README.md CHANGELOG.md]

  spec.add_runtime_dependency 'sequel', '~> 5.10'

  spec.add_dependency 'rubocop', '~> 0.63.0'
end
