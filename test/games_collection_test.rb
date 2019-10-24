require_relative 'test_helper'

class GamesCollectionTest < Minitest::Test

  def setup
    @games_collection = GamesCollection.new('./data/dummy_games.csv')
  end

  def test_it_exists
    assert_instance_of GamesCollection, @games_collection
  end

  def test_it_initializes_attributes
    assert_equal 99, @games_collection.games.length
    assert_equal true, @games_collection.games.all? {|game| game.is_a?(Game)}
  end

  def test_it_can_count_game_by_season

    expected = {
      "20122013" => 10,
      "20162017" => 10,
      "20142015" => 10,
      "20152016" => 10,
      "20132014" => 10
    }

    assert_equal expected, @games_collection.count_of_games_by_season
  end
end
