require 'simplecov'
require 'pry'
require 'rspec'

RSpec.configure do |config|
  config.formatter = :documentation
end
SimpleCov.start

# Previous content of test helper now starts here