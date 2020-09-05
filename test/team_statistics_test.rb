require './test/test_helper'
require './lib/stat_tracker'

class TeamStatisticsTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("games", StatTracker.generate_teams('./data/teams.csv'), "game_teams")
  end
end
