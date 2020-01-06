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
    assert_equal "away", @game_teams_collection.game_teams.first.hoa
  end

  def test_find_id_of_winningest_team
    assert_equal 6, @game_teams_collection.winningest_team_id
  end

  def test_find_id_of_team_with_best_fans
    assert_equal 3, @game_teams_collection.best_fans_team_id
  end

  def test_find_id_of_teams_with_worst_fans
    assert_equal [24, 5, 19], @game_teams_collection.worst_fans_team_id
  end

  def test_all_games_by_season
    assert_equal 3, @game_teams_collection.all_games_by_season("20142015").length
  end

  def test_most_tackles_team_id
    assert_equal 9, @game_teams_collection.most_tackles_team_id("20142015")
  end

  def test_fewest_tackles_team_id
    assert_equal 16, @game_teams_collection.fewest_tackles_team_id("20142015")
  end
  
  def test_highest_scoring_visitor
    assert_equal 5, @game_teams_collection.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal 3, @game_teams_collection.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal 6, @game_teams_collection.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 9, @game_teams_collection.lowest_scoring_home_team
  end
end
