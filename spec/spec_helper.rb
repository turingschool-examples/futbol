require "simplecov"
SimpleCov.start

require_relative 'stat_helper_spec'
require_relative 'stat_tracker_spec'
require_relative 'team_statistics_spec'

RSpec.configure do |config|
  config.formatter = :documentation
end
