require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require "csv"



class TestStatTracker <Minitest::Test

  def test_stat_tracker_can_pull_file_locations
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 7441, stat_tracker.games.length
    assert_equal 32, stat_tracker.teams.length
    assert_equal 14882, stat_tracker.game_teams.length
  end

end
