require_relative 'test_helper'
require_relative '../lib/games'


class GameTest < Minitest::Test

  def setup
    @line_2 = Game.new("2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null") # change to array of strings
  end

  def test_it_exists
    assert_instance_of Game, @line_2
  end

  def test_attributes
    assert_equal "2012030221", @line_2.game_id
    assert_equal '20122013', @line_2.season
    assert_equal "Postseason", @line_2.type
    assert_equal "5/16/13", @line_2.date_time
    assert_equal "3", @line_2.away_team_id
    assert_equal "6", @line_2.home_team_id
    assert_equal 2, @line_2.away_goals
    assert_equal 3, @line_2.home_goals
    assert_equal "Toyota Stadium", @line_2.venue
    assert_equal "/api/v1/venues/null", @line_2.venue_link
  end
end
