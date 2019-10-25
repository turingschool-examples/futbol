require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'

class GameTest < MiniTest::Test

  def setup
    @game = Game.new({game_id: "2012030221",season: "20122013",type: "Postseason", date_time: "5/16/13",away_team_id: "3",home_team_id: "6",away_goals: "2",home_goals: "3",venue: "Toyota Stadium",venue_link: "/api/v1/venues/null"})
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_initializes
    assert_equal "2012030221", @game.game_id
    assert_equal "Postseason", @game.type
    assert_equal "Toyota Stadium", @game.venue
  end

end
