require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require 'pry'
require 'csv'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_for_all_made_data
    assert_equal 32, @stat_tracker.all_teams.length
    assert_equal 7441, @stat_tracker.all_games.length
    assert_equal 14882, @stat_tracker.all_game_teams.length
  end
end
