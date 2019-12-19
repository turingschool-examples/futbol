require_relative '../test/testhelper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.new("./test/fixtures/games_trunc.csv", "./test/fixtures/teams_trunc.csv", "./test/fixtures/game_teams_trunc.csv")
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal "./test/fixtures/games_trunc.csv", @stat_tracker.games_path
    assert_equal "./test/fixtures/teams_trunc.csv", @stat_tracker.teams_path
    assert_equal "./test/fixtures/game_teams_trunc.csv", @stat_tracker.game_teams_path
  end

  def test_it_can_create_a_games_teams_collection
    assert_instance_of GameTeamsCollection, @stat_tracker.game_teams_collection
  end

  def test_it_can_create_a_games_collection
    assert_instance_of GamesCollection, @stat_tracker.games_collection
  end

  def test_it_can_create_a_teams_collection
    assert_instance_of TeamsCollection, @stat_tracker.teams_collection
  end

  def test_it_can_create_games_collection_averages
    assert_equal 3.93, @stat_tracker.average_goals_per_game
    assert_equal ({20122013=>4.0, 20142015=>3.88, 20152016=>4.0, 20162017=>4.0}), @stat_tracker.average_goals_by_season
  end

end
