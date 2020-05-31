require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/stat_tracker"
require 'pry'

class StatTrackerTest < Minitest::Test
  def setup

    game_path = './data/games.csv'
    team_path = './test/data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_works
    StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_tracker_can_fetch_game_data
    assert_equal 7441, @stat_tracker.games.count
    assert_instance_of Game, @stat_tracker.games.first
  end

  def test_tracker_can_fetch_team_data
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_tracker_can_fetch_game_team_data
    assert_equal 14882, @stat_tracker.game_teams.count
  end

  def test_it_returns_team_info_hash
    expected = {
                "team_id" => "54",
                "franchise_id" => "38",
                "team_name" => "Reign FC",
                "abbreviation" => "RFC",
                "link" => "/api/v1/teams/54"
               }
    assert_equal expected, @stat_tracker.team_info(54)
  end

  def test_it_returns_best_season_string
    assert_equal "20132014", @stat_tracker.best_season(6)
  end

  def test_it_returns_worst_season_string
    assert_equal "20142015", @stat_tracker.worst_season(6)
  end

  def test_it_returns_average_win_percentage_string
    assert_equal 0.49, @stat_tracker.average_win_percentage(6)
  end

  def test_it_can_return_most_goals_scored_integer
    assert_equal "7", @stat_tracker.most_goals_scored(18)
  end

  def test_it_can_return_fewest_goals_scored_integer
    assert_equal "0", @stat_tracker.fewest_goals_scored(18)
  end

  def test_it_can_return_favorite_opponent_string
    @stat_tracker.favorite_opponent(18)
    # assert_equal "DC United", @stat_tracker.favorite_opponent(18)
  end

end
