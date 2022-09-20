require "simplecov"
SimpleCov.start

require_relative 'stat_helper_spec'
require_relative 'stat_tracker_spec'
require_relative 'team_statistics_spec'
require_relative 'season_statistics_spec'
require_relative 'league_statistics_spec'
require_relative 'game_statistics_spec'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.configure { |c| c.profile_examples = true }
