require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './test/fixtures/games_truncated.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './test/fixtures/game_teams_truncated.csv'

    locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal @game_path, @stat_tracker.game_path
    assert_equal @team_path, @stat_tracker.team_path
    assert_equal @game_teams_path, @stat_tracker.game_teams_path
  end

  def test_it_can_create_a_game_collection
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_instance_of Array, @stat_tracker.game_collection.games
  end

  def test_it_can_create_a_game_teams_collection
    assert_instance_of GameTeamsCollection, @stat_tracker.game_teams_collection
    assert_instance_of Array, @stat_tracker.game_teams_collection.game_teams_array
  end
end
