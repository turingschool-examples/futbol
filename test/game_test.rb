require_relative './test_helper'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists_and_has_attributes
    game = Game.new(game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link)

    assert_instance_of Game, game
  end
end
