require_relative 'test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new({
        game_id: 2015030226,
        season: 20152016,
        type: "Postseason",
        away_team_id: 15,
        home_team_id: 5,
        away_goals: 3,
        home_goals: 2
      })
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_attribues
    assert_equal 2015030226, @game.game_id
    assert_equal 20152016, @game.season
    assert_equal "Postseason", @game.type
    assert_equal 15, @game.away_team_id
    assert_equal 5, @game.home_team_id
    assert_equal 3, @game.away_goals
    assert_equal 2, @game.home_goals
  end
end
