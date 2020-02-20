require_relative 'test_helper'
require './lib/data_loadable'
require './lib/game_teams'
require './lib/game_teams_stats'


class GameteamsStatsTest < Minitest::Test

  def setup
    @game_team_stats = GameTeamStats.new("./data/game_teams_truncated.csv", GameTeams)
    @game_teams = @game_team_stats.game_teams[1]
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

  def test_attributes_for_instance_of_game_teams_within_game_team_stats
    assert_equal 2012030221, @game_teams.game_id
    assert_equal 6, @game_teams.team_id
    assert_equal "home", @game_teams.hoa
    assert_equal "WIN", @game_teams.result
    assert_equal "OT", @game_teams.settled_in
    assert_equal "Claude Julien", @game_teams.head_coach
    assert_equal 3, @game_teams.goals
    assert_equal 12, @game_teams.shots
    assert_equal 51, @game_teams.tackles
  end

end
