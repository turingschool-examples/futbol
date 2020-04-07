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

    #@game_2 2013020177,20132014,Regular Season,10/29/13,24,4,3,2,SeatGeek Stadium,/api/v1/venues/null

    Game.from_csv("./test/fixtures/games_fixture.csv")
  end

  def test_it_exist
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal   2017030161, @game.game_id
    assert_equal  20172018 , @game.season
    assert_equal 'Postseason', @game.type
    assert_equal 30 , @game.away_team_id
    assert_equal  52 , @game.home_team_id
    assert_equal   2 , @game.away_goals
    assert_equal   3 , @game.home_goals
    assert_equal   'Providence Park' , @game.venue
    assert_equal   '/api/v1/venues/null' , @game.venue_link
  end

  def def_test_it_can_read_games_from_CSV


  end
end
