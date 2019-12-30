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
    skip
    # assert_equal expected, actual
    best_fans
  end

  def test_all_are_home_games
    skip
    assert_equal expected, @game_teams_collection.hoa_game_sorter("home")
  end
end
