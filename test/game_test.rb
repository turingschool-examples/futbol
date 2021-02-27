require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game = Game.new('./games_dummy.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
    assert_equal 2015030133, @game7.game_id
    assert_equal 20152016, @game7.season
    assert_equal "Postseason", @game7.type
    assert_equal "4/18/16", @game7.date_time
    assert_equal 15, @game7.away_team_id
    assert_equal 4, @game7.home_team_id
    assert_equal 4, @game7.away_goals
    assert_equal 1, @game7.home_goals
    assert_equal "SeatGeek Stadium", @game7.venue
    assert_equal "/api/v1/venues/null", @game7.venue_link
  end

  def test_total_goals
    assert_equal 29, @game.total_goals
  end

  def test_winner
    assert_equal :away, @game.winner
  end
end
