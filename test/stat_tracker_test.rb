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

  def test_best_offense
    assert_equal "DC United", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "New England Revolution", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "New England Revolution", @stat_tracker.lowest_scoring_home_team
  end

  def test_biggest_bust
    assert_equal "Montreal Impact", @stat_tracker.biggest_bust("20132014")
  end

  def test_biggest_surprise
     assert_equal "FC Cincinnati", @stat_tracker.biggest_surprise("20132014")
  end

  def test_winningest_coach
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Ted Nolan", @stat_tracker.worst_coach("20142015")
  end

end
