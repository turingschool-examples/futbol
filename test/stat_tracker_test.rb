require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/stat_tracker"
require 'pry'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/data/games.csv'
    team_path = './test/data/teams.csv'
    game_teams_path = './test/data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_tracker_can_fetch_game_data
    assert_equal 60, @stat_tracker.games.count
    assert_instance_of Game, @stat_tracker.games.first
  end

  def test_tracker_can_fetch_team_data
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_tracker_can_fetch_game_team_data
    assert_equal 52, @stat_tracker.game_teams.count
  end
# start game stat tests
  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins # 38 home wins in test data
    assert_equal 0.63, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins # 20 away wins in test data
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties # 2 draws in test data
    assert_equal 0.03, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = expected = {
      "20122013"=>57,
      "20162017"=>3
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game #235 goals in test data
    assert_equal 3.92, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>3.86, # 220 goals in test data
      "20162017"=>5 # 15 goals in test data
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
