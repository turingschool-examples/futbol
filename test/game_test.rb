require './test/test_helper'
require './lib/game'
require 'pry'

class GameTest < MiniTest::Test

  def setup
    game_param = {game_id: "2012030221",
                  season: "20122013",
                  away_team_id: 3,
                  home_team_id: 6,
                  away_goals: 2,
                  home_goals: 3
                  }

  @game = Game.new(game_param)

  end

  def test_game_exists

    assert_instance_of Game, @game

  end


end
