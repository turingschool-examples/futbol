require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game7 = Game.new({
                  game_id: 2012030221,
                  season: 20122013,
                  type: "Postseason",
                  date_time: "6/8/13",
                  away_team_id: 7,
                  home_team_id: 1,
                  away_goals: 10,
                  home_goals: 5,
                  venue: "Gillette Stadium",
                  venue_link: "/api/v1/venues/null"
                })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game7
    assert_equal 2012030221, @game7.game_id
    assert_equal 20122013, @game7.season
    assert_equal "Postseason", @game7.type
    assert_equal "6/8/13", @game7.date_time
    assert_equal 7, @game7.away_team_id
    assert_equal 1, @game7.home_team_id
    assert_equal 10, @game7.away_goals
    assert_equal 5, @game7.home_goals
    assert_equal "Gillette Stadium", @game7.venue
    assert_equal "/api/v1/venues/null", @game7.venue_link
  end
end
