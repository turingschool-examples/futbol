require './test/test_helper'
require './lib/game_collection'
require './lib/game'

class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./data/games.csv")
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
    assert_equal "20122013", @game.season
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.44, @game_collection.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.36, @game_collection.percentage_visitor_wins
  end

end
