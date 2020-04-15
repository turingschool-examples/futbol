require_relative 'test_helper'

class CollectionTest < Minitest::Test

  def test_it_exists
    assert_instance_of Collection, Collection.new
  end

  def test_create_objects
    collection = Collection.new
    game_collection = collection.create_objects("./data/games.csv", Game)
    team_collection = collection.create_objects("./data/teams.csv", Team)
    game_stats_collection = collection.create_objects("./data/game_teams.csv", GameStats)
    assert_instance_of Game, game_collection[0]
    assert_equal 7441, game_collection.length
    assert_instance_of Team, team_collection[0]
    assert_equal 32, team_collection.length
    assert_instance_of GameStats, game_stats_collection[0]
    assert_equal 14882, game_stats_collection.length
  end
end
