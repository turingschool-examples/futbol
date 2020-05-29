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
    assert_equal 480, @stat_tracker.games.count
    assert_instance_of Game, @stat_tracker.games.first
  end

  def test_tracker_can_fetch_team_data
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_tracker_can_fetch_game_team_data
    assert_equal 14882, @stat_tracker.game_teams.count
  end

  def test_it_returns_team_info_hash
    assert_equal 54, @stat_tracker.team_info(54)[:team_id].to_i
    assert_equal "Reign FC", @stat_tracker.team_info(54)[:team_name]
  end

  def test_it_returns_best_season_string
    @stat_tracker.best_season(54)
  end




end
