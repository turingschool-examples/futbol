require_relative 'test_helper'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    row = {game_id: 2012030223,
            season: 20122013,
            type: "Postseason",
            date_time: "5/21/13",
            away_team_id: 6,
            home_team_id: 3,
            away_goals: 2,
            home_goals: 1,
            venue: "BBVA Stadium",
            venue_link: "/api/v1/venues/null"
          }
    @game = Game.new(row)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal 2012030223, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/21/13", @game.date_time
    assert_equal 6, @game.away_team_id
    assert_equal 3, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 1, @game.home_goals
    assert_equal "BBVA Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

end
