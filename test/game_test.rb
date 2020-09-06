require "./test/test_helper"
require "./lib/game"

class GameTest < Minitest::Test
  def setup
    Game.from_csv
  end
  def test_it_can_read_from_csv
    assert_equal 6, Game.all_games.count
  end

  def test_it_can_have_attributes
    game1 = Game.all_games[0]

    assert_equal 2014020006, game1.game_id
    assert_equal "20142015", game1.season
    assert_equal "Regular Season", game1.type
    assert_equal "10/9/14", game1.date_time
    assert_equal 1, game1.away_team_id
    assert_equal 4, game1.home_team_id
    assert_equal 4, game1.away_goals
    assert_equal 2, game1.home_goals
    assert_equal "SeatGeek Stadium", game1.venue
    assert_equal "/api/v1/venues/null", game1.venue_link
  end
end
