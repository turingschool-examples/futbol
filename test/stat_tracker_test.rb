require_relative '../test/testhelper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({ :games => "./test/fixtures/games_trunc.csv", :teams => "./test/fixtures/teams_trunc.csv", :game_teams => "./test/fixtures/game_teams_trunc.csv"})
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

  def test_best_offence
    assert_equal "DC United", @stat_tracker.best_offence
  end

  def test_worst_offence
    assert_equal "New England Revolution", @stat_tracker.worst_offence
  end

  def test_highest_scoring_visitor_id
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

end
