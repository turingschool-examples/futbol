require_relative './test_helper'
require 'csv'
require_relative '../lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    @collection = GameCollection.new('./test/fixtures/games_truncated.csv')
    @game = @collection.games.first
  end
  def test_team_collection_exists
    assert_instance_of GameCollection, @collection
  end

  def test_game_collection_has_games
    assert_instance_of Array, @collection.games
    assert_equal 8, @collection.games.length
  end

  def test_game_collection_can_create_games_from_csv
    assert_instance_of Game, @game
    assert_equal 'Postseason', @game.type
    assert_equal '20122013', @game.season
  end
end
