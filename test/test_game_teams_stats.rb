require_relative 'test_helper'
require './lib/data_loadable'
require './lib/game_teams'
require './lib/game_teams_stats'

class GameteamsStatsTest < Minitest::Test

  def setup
    @game_Team_stats = GameTeamStats.new("./data/game_teams_truncated.csv", GameTeams)
  end

  def test_it_exists
    assert_instance_of GameTeamStats, @game_Team_stats
  end
end
