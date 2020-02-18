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
    assert_equal './data/games_truncated.csv', @stat_tracker.games_path
    assert_equal './data/game_teams_truncated.csv', @stat_tracker.game_teams_path
    assert_equal './data/teams.csv', @stat_tracker.team_path
  end

end
