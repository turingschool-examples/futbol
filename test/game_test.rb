require './test/test_helper'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test
  def setup
  @game = Game.new({
    game_id: 2017030161,
    season: 20172018,
    type: 'Postseason',
    date_time: '4/11/18',
    away_team_id: 30,
    home_team_id: 52,
    away_goals: 2,
    home_goals: 3,
    venue: 'Providence Park',
    venue_link: '/api/v1/venues/null'})

    Game.from_csv("./test/fixtures/games_fixture.csv")
  end

  def test_it_exist
    assert_instance_of Game, @game
  end
end
