require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'
require './lib/game'


class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./fixtures/games_fixture.csv")

  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_collect_games
    assert_instance_of Game, @game_collection.all.first
    assert_equal 5, @game_collection.all.count
  end
end
