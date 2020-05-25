require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    game_params = {game_id: "2012030221",
                    season: "20122013",
                    away_team_id: "3",
                    home_team_id: "6"}
    @game = Game.new(game_params)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
  end
end
