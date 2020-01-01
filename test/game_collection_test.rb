require_relative './test_helper'
require 'csv'
require_relative '../lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    @collection = GameCollection.new('./test/fixtures/games_truncated.csv')
    @game = @collection.collection.first
  end

  def test_team_collection_exists
    assert_instance_of GameCollection, @collection
  end

  def test_game_collection_has_games
    assert_instance_of Hash, @collection.collection
    assert_equal 13, @collection.collection.length
  end

  def test_game_collection_can_create_games_from_csv
    assert_instance_of Array, @game
    assert_equal 'Postseason', @game[1].type
    assert_equal '20122013', @game[1].season
    assert_equal '1', @game[1].away_goals
  end
end
