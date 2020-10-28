require 'CSV'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/games_repo'
require './lib/game'

class GameTest < Minitest::Test
  def setup

    row = CSV.readlines('./data/games.csv', headers: :true, header_converters: :symbol)[0]
    @parent = mock()
    @game1 = Game.new(row, @parent)
  end

  def test_it_exists_and_has_attributes
    assert_equal 2012030221, @game1.game_id
    assert_equal 20122013, @game1.season
  end
end