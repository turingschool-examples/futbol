require './test/test_helper'
require './lib/game'
require './lib/game_collection'


class GameCollectionTest < Minitest::Test

  def setup
    @game_collection = GameCollection.new('./data/games_fixture.csv')
    @game = @game_collection.games_array.first
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_collection.games_array
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Game, @game
    assert_equal "2012030221", @game.game_id
  end
end
