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

  def test_it_grabs_highest_total_score
    assert_equal 7, @games_collection.highest_total_score
  end

  def test_it_grabs_lowest_total_score
    assert_equal 1, @games_collection.lowest_total_score
  end

  def test_it_can_return_total_goals_across_all_games
    assert_equal 387, @games_collection.total_goals(@games_collection.games)
  end

  def test_it_can_get_array_of_every_element_in_a_given_column
    assert_instance_of Array, @games_collection.every("game_id", @games_collection.games)
    assert_equal 99, @games_collection.every("game_id", @games_collection.games).length
  end

  def test_it_can_get_array_of_every_unique_element_in_a_given_column
    assert_equal 99, @games_collection.every_unique("game_id", @games_collection.games).length
  end

  def test_it_can_count_total_unique_elements_in_a_given_column
    assert_equal 99, @games_collection.total_unique("game_id", @games_collection.games)
  end

  def test_it_can_total_goals_for_given_game
    assert_equal 5, @games_collection.goals(@games_collection.games[0])
    assert_equal 3, @games_collection.goals(@games_collection.games[2])
    assert_equal 4, @games_collection.goals(@games_collection.games[4])
  end

  def test_it_can_calculate_average_goals_for_selection_of_games
    assert_equal 4.40, @games_collection.average_goals_in(@games_collection.games[0..4])
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 3.91, @games_collection.average_goals_per_game
  end

  def test_it_can_select_all_games_in_given_season
    assert_equal 4, @games_collection.all_games_in_season("20162017").length
    assert_equal 16, @games_collection.all_games_in_season("20142015").length
  end

  def test_it_can_return_hash_of_average_goals_by_season
    expected_hash = {
                      "20122013"=>3.86,
                      "20162017"=>4.75,
                      "20142015"=>3.75,
                      "20152016"=>3.88,
                      "20132014"=>4.33
                    }
    assert_equal expected_hash, @games_collection.average_goals_by_season
  end
end
