require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'



class TestStatTracker <Minitest::Test



  def test_stat_tracker_has_attributes
    stat_tracker = StatTracker.new

    assert_equal nil, stat_tracker.game
    assert_equal nil, stat_tracker.teams
    assert_equal nil, stat_tracker.game_teams
  end

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

    assert_equal game_path, stat_tracker.games
    assert_equal team_path, stat_tracker.teams
    assert_equal game_teams_path, stat_tracker.game_teams
  end

end
