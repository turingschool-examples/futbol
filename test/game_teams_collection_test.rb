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
end
