require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_stat_collection'

class GameTest < Minitest::Test

  def setup
    csv_path = (CSV.read "./data/games.csv", headers: true, header_converters: :symbol)
    @game = Game.new(csv_path)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_initializes
    assert_equal 2012030221, @game.game_id.first.to_i
  end
end
