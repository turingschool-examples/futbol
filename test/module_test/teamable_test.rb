require "minitest/autorun"
require "minitest/pride"
require "./lib/teamable"
require "./lib/stat_tracker"


class TeamableModuleTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/games.csv'
    team_path = './data/dummy_data/teams.csv'
    game_team_path = './data/dummy_data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_team_info
    assert_equal hash, @stat_tracker.team_info
  end

  def test_best_season
    assert_equal int, @stat_tracker.best_season
  end

  def test_worst_season
    assert_equal int, @stat_tracker.worst_season
  end

  def test_average_win_percentage
    assert_equal float, @stat_tracker.average_win_percentage
  end

  def test_most_goals_scored
    assert_equal int, @stat_tracker.most_goals_scored
  end

  def test_fewest_goals_scored
    assert_equal int, @stat_tracker.fewest_goals_scored
  end

  def test_favorite_opponent
    assert_equal "string", @stat_tracker.favorite_opponent
  end

  def test_rival
    assert_equal "string", @stat_tracker.rival
  end

  def test_biggest_blowout
    assert_equal int, @stat_tracker.biggest_blowout
  end

  def test_worst_loss
    assert_equal int, @stat_tracker.worst_loss
  end

  def test_head_to_head

    assert_equal expected_hash, @stat_tracker.head_to_head
  end

  def test_seasonal_summary

    assert_equal expected_hash, @stat_tracker.seasonal_summary
  end
