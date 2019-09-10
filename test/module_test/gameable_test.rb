require "minitest/autorun"
require "minitest/pride"
require "./lib/modules/gameable"
require "./lib/stat_tracker"


class GameableModuleTest < Minitest::Test

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

  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 2, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.33, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.44, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.22, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected_hash = {
      "20132014" => 10,
      "20142015" => 8
    }
    assert_equal expected_hash, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.72, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected_hash = {
      "20132014" => 3.70,
      "20142015" => 3.75
    }
    assert_equal expected_hash, @stat_tracker.average_goals_by_season
  end
end
