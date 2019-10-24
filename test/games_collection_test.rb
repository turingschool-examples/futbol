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

  def test_it_can_find_games_by_season
    expected = [
      "20122013",
      "20162017",
      "20142015",
      "20152016",
      "20132014"
    ]

    assert_equal expected, @games_collection.unique_seasons
  end

  def test_it_knows_the_number_of_games_in_each_season
    expected = [
      57,
      4,
      16,
      16,
      6
    ]

    assert_equal expected, @games_collection.number_of_games_in_each_season
  end

  def test_it_can_count_game_by_season

    expected = {
      "20122013" => 57,
      "20162017" => 4,
      "20142015" => 16,
      "20152016" => 16,
      "20132014" => 6
    }

    assert_equal expected, @games_collection.count_of_games_by_season
  end
end
