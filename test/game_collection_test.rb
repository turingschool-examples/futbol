require './test/test_helper'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game = @game_collection.games.first
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_collection.games
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Game, @game
    assert_equal "20162017", @game.season
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_it_can_calculate_average_goals_per_game
    expected = 4.31 #to-do: set up dummy test b/c idk if this is accurate
    assert_equal  expected, @game_collection.average_goals_per_game
  end

  def test_it_can_store_games_by_season
    #to-do: change to account for dummy test stats
    assert_equal 4, @game_collection.games_by_season.length
  end

  def test_it_can_calculate_average_goals_by_season
    #to-do: change to account for dummy test stats
    avg_goals_by_season = @game_collection.average_goals_by_season
    assert_equal 4.43, avg_goals_by_season["20132014"]
    assert_equal 3.43, avg_goals_by_season["20142015"]
    assert_equal 4.64, avg_goals_by_season["20152016"]
    assert_equal 4.8, avg_goals_by_season["20162017"]
  end
end
