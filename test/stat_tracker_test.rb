require './test/test_helper'
require './lib/stat_tracker'

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

  def test_it_has_attributes
    assert_equal './data/games.csv', @stat_tracker.game_path
    assert_equal './data/teams.csv', @stat_tracker.team_path
    assert_equal './data/game_teams.csv', @stat_tracker.game_teams_path
  end

  def test_it_can_create_a_game_collection
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_instance_of Array, @stat_tracker.game_collection.games
  end

  # def test_it_can_create_a_team_collection
  #   assert_instance_of TeamCollection, @stat_tracker.team_collection
  #   assert_instance_of Array, @stat_tracker.team_collection.teams
  # end

  def test_it_can_create_a_game_teams_collection
    assert_instance_of GameTeamsCollection, @stat_tracker.game_teams_collection
    assert_instance_of Array, @stat_tracker.game_teams_collection.game_teams_array
  end
end
