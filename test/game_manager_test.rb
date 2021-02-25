require './test/test_helper'
require './lib/game_manager'


class GameManagerTest < Minitest::Test

  def test_it_exists
    # fake_data = {game_id: 2012030221, season: 20122013, type: "Postseason", date_time: "5/16/13", away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3, venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"}
    #
    # game = Game.new(fake_data)
    m=mock
    m.stubs(:foreach).returns([])


    assert_instance_of GameManager, ------
  end

  def test_it_has_attributes

  end
end
