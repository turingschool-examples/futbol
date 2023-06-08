require 'simplecov'
SimpleCov.start
# keep at top
require './lib/stats_manager'
require './lib/game'
require './lib/team'
require './lib/game_team'
RSpec.configure do |config|
  config.formatter = :documentation
end