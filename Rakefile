require "rubygems"
require "rake"
require "rake/testtask"
require "rake/clean"
require "bundler"
require 'rspec/core/rake_task'

Bundler.require(:default, :test)

RSpec::Core::RakeTask.new(:spec)

task default: [:spec]

NAME = "sequel-asterisk-hunter"
VERSION = lambda do
  require File.expand_path("../lib/sequel-asterisk-hunter/version", __FILE__)
  SequelAsteriskHunter::VERSION
end

# Gem packaging
desc "Build the gem"
task package: [:clean] do
  sh %{#{FileUtils::RUBY} -S gem build sequel-asterisk-hunter.gemspec}
end

desc "Publish the gem to rubygems.org"
task release: [:package] do
  sh %{#{FileUtils::RUBY} -S gem push ./#{NAME}-#{VERSION.call}.gem}
end
