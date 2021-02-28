require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game = Game.new({
            game_id: 2015030133,
            season: 20152016,
            type: "Postseason",
            date_time: "4/18/16",
            away_team_id: 15,
            home_team_id: 4,
            away_goals: 4,
            home_goals: 1,
            venue: "SeatGeek Stadium",
            venue_link: "/api/v1/venues/null"})
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
    assert_equal 2015030133, @game.game_id
    assert_equal 20152016, @game.season
    assert_equal "Postseason", @game.type
    assert_equal "4/18/16", @game.date_time
    assert_equal 15, @game.away_team_id
    assert_equal 4, @game.home_team_id
    assert_equal 4, @game.away_goals
    assert_equal 1, @game.home_goals
    assert_equal "SeatGeek Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_total_goals
    assert_equal 5, @game.total_goals
  end

  def test_winner
    assert_equal :visitor, @game.winner
  end
end
