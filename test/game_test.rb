require_relative 'test_helper'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def setup
    @first_truncated_game = Game.new( {
                                        season: 20122013,
                                        type: "Postseason",
                                        date_time: 5/16/13,
                                        away_team_id: 3,
                                        home_team_id: 6,
                                        away_goals: 2,
                                        home_goals: 3,
                                        venue: "Toyota Stadium",
                                        venue_link: "/api/v1/venues/null"
      } )
  end

  def test_games_exists
    assert_instance_of Game, @first_truncated_game
  end

  def test_games_has_attributes
    assert_equal "Postseason", @first_truncated_game.type
    assert_equal 20122013, @first_truncated_game.season
    assert_equal 5/16/13, @first_truncated_game.date_time
    assert_equal 3, @first_truncated_game.away_team_id
    assert_equal 6, @first_truncated_game.home_team_id
    assert_equal 2, @first_truncated_game.away_goals
    assert_equal 3, @first_truncated_game.home_goals
    assert_equal "Toyota Stadium", @first_truncated_game.venue
    assert_equal "/api/v1/venues/null", @first_truncated_game.venue_link
  end
end
