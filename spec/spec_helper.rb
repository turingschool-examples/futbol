require "simplecov"
SimpleCov.start

require_relative 'stat_tracker_spec'

RSpec.configure do |config|
  config.formatter = :documentation
end
