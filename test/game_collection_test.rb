require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
require_relative '../lib/game_collection'
require 'csv'

class GameCollectionTest < Minitest::Test
  def setup
    @game_file_path = './fixture_files/games_fixture.csv'
    @game_data = CSV.read('./fixture_files/games_fixture.csv',
                 headers: true,
                 header_converters: :symbol)
    @game_collection = GameCollection.new(@game_data)

  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
    assert_instance_of Game, @game_collection.games.first
    assert_equal 9, @game_collection.games.length
  end

  def test_it_can_return_the_highest_total_score
    assert_equal 5, @game_collection.highest_total_score
    #harness pass
  end

  def test_it_can_return_lowest_score
    assert_equal 3, @game_collection.lowest_total_score
    #harness pass
  end
end
