require './test/helper_test'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    game_info = {
      game_id: "2012020122",
      season: "20122013",
      type: "Regular Season",
      date_time: "2/3/13",
      away_team_id: "1",
      home_team_id:	"2",
      away_goals:	"3",
      home_goals:	"0"
    }

    @game = Game.new(game_info)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_game_info_attributes
    assert_equal "2012020122",@game.game_id
    assert_equal "20122013",@game.season
    assert_equal "Regular Season",@game.type
    assert_equal "2/3/13",@game.date_time
    assert_equal "1",@game.away_team_id
    assert_equal "2",@game.home_team_id
    assert_equal 3, @game.away_goals
    assert_equal 0, @game.home_goals
  end
end
