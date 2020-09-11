require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    data = CSV.read('./data/games_dummy.csv', headers:true)
    game = Game.new(data[0], "manager")

    assert_instance_of Game, game
    assert_instance_of CSV::Table, data
  end

  def test_it_has_attributes
    data = CSV.read('./data/games_dummy.csv', headers:true)
    game = Game.new(data[0], "manager")

    assert_equal "2013020674", game.game_id
    assert_equal "20132014", game.season
    assert_equal "Regular Season", game.type
    assert_equal "1/11/14", game.date_time
    assert_equal "19", game.away_team_id
    assert_equal "23", game.home_team_id
    assert_equal "1", game.away_goals
    assert_equal "2", game.home_goals
    assert_equal "Saputo Stadium", game.venue
  end
end
