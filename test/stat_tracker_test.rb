require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

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

  def test_it_has_readable_attributes
    assert_equal './data/games.csv', @stat_tracker.game_path
    assert_equal './data/teams.csv', @stat_tracker.teams_path
    assert_equal './data/game_teams.csv', @stat_tracker.game_teams_path
  end

  def test_from_csv_creates_array_of_all_games
    assert_instance_of Array, @stat_tracker.games
    assert_equal 7441, @stat_tracker.games.length
    assert_instance_of Game, @stat_tracker.games[0]
    assert_instance_of Game, @stat_tracker.games[-1]
  end
end
