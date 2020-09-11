require_relative 'test_helper'

class GameTest < Minitest::Test

  def test_it_exists_with_attributes
    game = Game.new({game_id: 1,
                     season: "2012",
                     type: "OT",
                     date_time: "9/1/20",
                     away_team_id: "7",
                     home_team_id: "3",
                     away_goals: 5,
                     home_goals: 1}, "manager")

    assert_instance_of Game, game
    assert_equal 1, game.game_id
    assert_equal "2012", game.season
    assert_equal "OT", game.type
    assert_equal "9/1/20", game.date_time
    assert_equal "3", game.home_team_id
    assert_equal "7", game.away_team_id
    assert_equal 5, game.away_goals
    assert_equal 1, game.home_goals
  end

end
