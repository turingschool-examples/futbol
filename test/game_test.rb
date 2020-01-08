require_relative 'testhelper'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new({})
    assert_instance_of Game, game
  end

  def test_it_has_attributes
    game = Game.new({game_id: 1,
                     season: 20122013,
                     away_team_id: 3,
                     home_team_id: 2,
                     away_goals: 1,
                     home_goals: 2,
                     type: "Postseason"
                     })
    assert_equal 1, game.game_id
    assert_equal 20122013, game.season
    assert_equal 3, game.away_team_id
    assert_equal 2, game.home_team_id
    assert_equal 1, game.away_goals
    assert_equal 2, game.home_goals
    assert_equal "Postseason", game.type

    # game_2 = mock('game')
    game_2 = Game.new({})
    game_2.stubs(:type).returns("Regular Season")
    game_2.stubs(:season).returns(20192020)

    assert_equal "Regular Season", game_2.type
    assert_equal 20192020, game_2.season
  end
end
