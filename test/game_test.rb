require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    fake_data = {game_id: 2012030221, season: 20122013, type: "Postseason", date_time: "5/16/13", away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3, venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"}
    game = Game.new(fake_data)

    assert_instance_of Game, game
  end

  def test_it_has_attributes
    fake_data = {game_id: 2012030221, season: 20122013, type: "Postseason", date_time: "5/16/13", away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3, venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"}
    game = Game.new(fake_data)

    assert_equal fake_data, game.row_data
  end
end

# game_id
# season
# type
# date_time
# away_team_id
# home_team_id
# away_goals
# home_goals
# venue
# venue_link
