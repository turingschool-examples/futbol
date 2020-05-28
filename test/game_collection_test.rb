require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @game_collection = GameCollection.new(@game_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_return_all_games
    assert_instance_of Game, @game_collection.all[0]
  end

  # def test_all
  #
  # end

end
