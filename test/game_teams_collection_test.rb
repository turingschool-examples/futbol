require_relative 'testhelper'
require_relative '../lib/stat_tracker'

class GameTeamsCollectionTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("./test/fixtures/games_trunc.csv", "./test/fixtures/teams_trunc.csv", "./test/fixtures/game_teams_trunc.csv")
    @game_teams_collection = GameTeamsCollection.new(@stat_tracker.game_teams_path)
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
    assert_equal Array, @game_teams_collection.game_teams.class
  end

  def test_it_creates_game_teams
    assert_instance_of GameTeam, @game_teams_collection.game_teams.first
    assert_equal "Claude Julien", @game_teams_collection.game_teams.first.head_coach
    assert_equal 4, @game_teams_collection.game_teams.first.goals
  end

  def test_highest_scoring_visitor
    assert_equal 6, @game_teams_collection.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal 3, @game_teams_collection.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal 2, @game_teams_collection.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 16, @game_teams_collection.lowest_scoring_home_team
  end

  # def test_biggest_bust_id
  #   stat_tracker = StatTracker.new("./data/games.csv", "./data/teams.csv", "./data/game_teams.csv")
  #   game_teams_collection = GameTeamsCollection.new(stat_tracker.game_teams_path)
  #
  #   assert_equal 23, game_teams_collection.biggest_bust_id("20132014")
  # end
  #
  # def test_biggest_surprise_id
  #   stat_tracker = StatTracker.new("./data/games.csv", "./data/teams.csv", "./data/game_teams.csv")
  #   game_teams_collection = GameTeamsCollection.new(stat_tracker.game_teams_path)
  #
  #   assert_equal 26, game_teams_collection.biggest_surprise_id("20132014")
  # end

  # def test_winningest_coach_name
  #
  #   assert_equal "Alain Vigneault", @game_teams_collection.winningest_coach_name("20142015")
  # end
  #
  # def test_worst_coach_name
  #
  #   assert_equal "Ted Nolan", @game_teams_collection.worst_coach_name("20142015")
  # end



end
