
require './test/test_helper'
require './lib/stat_tracker'
require 'csv'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

  end

  def test_it_exists
    # skip
    stat_tracker = StatTracker.from_csv(@locations[:games])

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_can_show_first_game
    # skip
    stat_tracker = StatTracker.from_csv(@locations[:games])

    assert_equal 14, stat_tracker.highest_total_score
  end

end
