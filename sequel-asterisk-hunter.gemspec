# frozen_string_literal: true

begin
  require "./lib/sequel-asterisk-hunter/version"
rescue LoadError
  module SequelAsteriskHunter; VERSION = "0"; end
end

Gem::Specification.new do |spec|
  spec.name          = "sequel-asterisk-hunter"
  spec.version       = SequelAsteriskHunter::VERSION
  spec.authors       = ["Danilo Barion Nogueira"]
  spec.email         = "danilo.barion@gmail.com"
  spec.summary       = "The Sequel extension which allow you to find all your 'SELECT * FROM ...' queries."
  spec.description   = "The Sequel extension which allow you to find all your 'SELECT * FROM ...' queries."
  spec.homepage      = "https://github.com/danilobarion1986/sequel-asterisk-hunter"
  spec.license       = "MIT"

  spec.require_paths = ["lib"]
  spec.files         = Dir.glob("{bin,lib}/**/*") + \
                       %w(LICENSE README.md CHANGELOG.md)

  spec.add_runtime_dependency "sequel", ">= 3.48.0"
end
