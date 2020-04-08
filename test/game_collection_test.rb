require_relative 'test_helper'
require './lib/game_collection'
require './lib/game'

class GameCollectionClass < Minitest::Test
  def setup
    file_path = './test/fixtures/truncated_games.csv'
    @game_collection = GameCollection.new(file_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

end
