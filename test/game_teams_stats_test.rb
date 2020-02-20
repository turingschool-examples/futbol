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

  def test_game_teams_stats_scoring
    assert_equal "FC Cincinnati", @game_team_stats.scoring('away','low')
    assert_equal "Real Salt Lake", @game_team_stats.scoring('away','win')
  end

  def test_game_teams_stats_low_or_high
    fake_hash = {1 => 4.0, 2 => 5.5, 3 => 4.5}
    assert_equal 2, @game_team_stats.low_or_high('win', fake_hash)
    assert_equal 1, @game_team_stats.low_or_high('low', fake_hash)
  end

  def test_game_teams_stats_update_scoring_hash
    scoring_hash = {}
    result = {6 => [3,1]}
    assert_equal result, @game_team_stats.update_scoring_hash(scoring_hash, @game_teams)
  end

  def test_game_teams_stats_lowest_visitor_score
    assert_equal "FC Cincinnati", @game_team_stats.lowest_scoring_visitor
  end

  def test_game_teams_stats_lowest_home_score
    assert_equal "Toronto FC", @game_team_stats.lowest_scoring_home_team
  end

  def test_game_teams_stats_highest_scoring_visitor
    assert_equal "Real Salt Lake", @game_team_stats.highest_scoring_visitor
  end

  def test_game_teams_stats_highest_scoring_home_team
    assert_equal "FC Dallas", @game_team_stats.highest_scoring_home_team
  end

end
