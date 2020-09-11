require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'

class GameTest < Minitest::Test
  def test_it_exists
    data = CSV.read('./data/games_dummy.csv', headers:true)
    game = Game.new(data[0], "manager")

    assert_instance_of Game, game
    assert_instance_of CSV::Table, data
  end


end
