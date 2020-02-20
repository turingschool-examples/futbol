require_relative 'test_helper'
require './lib/data_loadable'
require './lib/game_teams'
require './lib/game_teams_stats'

class GameTeamStatsTest < Minitest::Test

  def setup
    @game_team_stats = GameTeamStats.new("./data/game_teams_truncated.csv", GameTeams)
  end

  def test_it_exists
    assert_instance_of GameTeamStats, @game_team_stats
  end

  def test_it_can_name_team_with_best_fans
    game_team_stats = GameTeamStats.new("./data/game_teams_truncated_with_best_fans.csv", GameTeams)
    assert_equal "FC Dallas", game_team_stats.best_fans
  end

  def test_it_can_list_teams_with_worst_fans
    assert_equal ["Real Salt Lake", "Minnesota United FC"], @game_team_stats.worst_fans
  end

end
