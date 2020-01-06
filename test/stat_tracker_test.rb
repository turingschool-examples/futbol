require_relative '../test/testhelper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({ :games => "./data/games.csv", :teams => "./test/fixtures/teams_trunc.csv", :game_teams => "./data/game_teams.csv"})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    skip
    assert_equal "./test/fixtures/games_trunc.csv", @stat_tracker.games_path
    assert_equal "./test/fixtures/teams_trunc.csv", @stat_tracker.teams_path
    assert_equal "./test/fixtures/game_teams_trunc.csv", @stat_tracker.game_teams_path
  end

  def test_it_can_create_a_games_teams_collection
    skip
    assert_instance_of GameTeamsCollection, @stat_tracker.game_teams_collection
  end

  def test_it_can_create_a_games_collection
    skip
    assert_instance_of GamesCollection, @stat_tracker.games_collection
  end

  def test_it_can_create_a_teams_collection
    assert_instance_of TeamsCollection, @stat_tracker.teams_collection
  end

  def test_name_of_best_offense
    skip
    assert_equal "DC United", @stat_tracker.best_offense
  end

  def test_name_of_worst_offense
    skip
    assert_equal "New England Revolution", @stat_tracker.worst_offense
  end

  def test_name_of_best_defense
    skip
    assert_equal "LA Galaxy", @stat_tracker.best_defense
  end

  def test_name_of_worst_defense
    skip
    assert_equal "Utah Royals FC", @stat_tracker.worst_defense
  end

  def test_name_of_winningest_team
    skip
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_name_of_team_with_best_fans
    skip
    assert_equal "Houston Dynamo", @stat_tracker.best_fans
  end

  def test_names_of_teams_with_worst_fans
    skip
    assert_equal ["Real Salt Lake", "Sporting Kansas City", "Philadelphia Union"], @stat_tracker.worst_fans
  end

  def test_most_tackles
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  def test_fewest_tackles
    skip
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
  end
end
