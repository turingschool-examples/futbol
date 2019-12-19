require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/dummy/games_trunc.csv'
    team_path = './test/dummy/teams_trunc.csv'
    game_teams_path = './test/dummy/game_teams_trunc.csv'

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

  def test_it_has_attributes
    assert_equal './test/dummy/games_trunc.csv', @stat_tracker.game_path
    assert_equal './test/dummy/teams_trunc.csv', @stat_tracker.team_path
    assert_equal './test/dummy/game_teams_trunc.csv', @stat_tracker.game_team_path
  end

  def test_it_can_create_a_game_collection
    assert_instance_of Array, @stat_tracker.games
    assert_equal 8, @stat_tracker.games.length
    assert_instance_of Game, @stat_tracker.games.first
  end

  def test_it_can_create_a_team_collection
    assert_instance_of Array, @stat_tracker.teams
    assert_equal 6, @stat_tracker.teams.length
    assert_instance_of Team, @stat_tracker.teams.first
  end

  def test_it_can_create_a_game_team_collection
    assert_instance_of Array, @stat_tracker.game_teams
    assert_equal 10, @stat_tracker.game_teams.length
    assert_instance_of GameTeam, @stat_tracker.game_teams.first
  end
end
