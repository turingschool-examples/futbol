require_relative 'test_helper'
require './lib/data_loadable'
require './lib/game_teams'
require './lib/game_teams_stats'

class GameteamsStatsTest < Minitest::Test

  def setup
    @game_team_stats = GameTeamStats.new("./data/game_teams_truncated.csv", GameTeams)
  end

  def test_it_exists
    assert_instance_of GameTeamStats, @game_team_stats
  end

  def test_it_can_find_team_with_lowest_home_goals
    assert_equal 'Toronto FC', @game_team_stats.lowest_scoring_visitor
  end
end
