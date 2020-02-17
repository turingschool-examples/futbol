require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_initialize_from_correct_file_plath
    assert_equal './data/games_truncated.csv', @stat_tracker.game_path
    assert_equal './data/game_teams_truncated.csv', @stat_tracker.game_teams_path
    assert_equal './data/teams.csv', @stat_tracker.team_path
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 66.67, @stat_tracker.percentage_home_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 14.29, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_by_season
    games_by_season = {
      "20152016" => 3,
      "20132014" => 2,
      "20142015" => 1,
      "20162017" => 1
    }

    assert_equal games_by_season, @stat_tracker.count_of_games_by_season
  end
end
