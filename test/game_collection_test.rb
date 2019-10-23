require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test

  def test_it_exists
    game_collection = GameCollection.new("./data/games_sample.csv")

    assert_instance_of GameCollection, game_collection
  end

  def test_it_has_total_games
    game_collection = GameCollection.new("./data/games_sample.csv")

    game_collection.create_games('./data/games_sample.csv')
    assert_equal 3, game_collection.total_games.length
  end

  def test_it_can_calculate_highest_total_score
    # look at our dumb file and figure out what that is
    # assert_equal number, game_collection.highest_total_score
  end

end
