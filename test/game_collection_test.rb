require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'
require 'csv'

class GameCollectionTest < Minitest::Test
  def setup
    @game_file_path = './data/little_games.csv'
    @game_data = CSV.read('./data/little_games.csv',
                 headers: true,
                 header_converters: :symbol)
    @game_collection = GameCollection.new(@game_data)

  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
    assert_instance_of Game, @game_collection.games.first
    assert_equal 4, @game_collection.games.length
  end
end
