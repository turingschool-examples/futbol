require_relative 'test_helper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
                  games: '../data/dummy_games.csv',
                  teams: '../data/dummy_teams.csv',
                  game_teams: '../data/dummy_game_teams.csv'
                }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_initializes_with_attributes
    assert_equal @locations[:games], @stat_tracker.games_path
    assert_equal @locations[:teams], @stat_tracker.teams_path
    assert_equal @locations[:game_teams], @stat_tracker.game_teams_path
  end
end
