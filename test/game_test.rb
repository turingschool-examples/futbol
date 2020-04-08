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
    @game_2 = Game.all[-1]
  end

  def test_it_exist
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal   2017030161, @game.game_id
    assert_equal  20172018 , @game.season
    assert_equal 'Postseason', @game.type
    assert_equal '4/11/18', @game.date_time
    assert_equal 30 , @game.away_team_id
    assert_equal  52 , @game.home_team_id
    assert_equal   2 , @game.away_goals
    assert_equal   3 , @game.home_goals
    assert_equal   'Providence Park' , @game.venue
    assert_equal   '/api/v1/venues/null' , @game.venue_link
  end

  def def_test_it_can_read_games_from_CSV
     assert_equal 2012020122 , @game_2.game_id
     assert_equal 20122013 ,  @game_2.season
     assert_equal 'Regular Season' , @game_2.type
     assert_equal '2/3/13' , @game_2.date_time
     assert_equal 1 , @game_2.away_team_id
     assert_equal 2 , @game_2.home_team_id
     assert_equal 3 , @game_2.away_goals
     assert_equal 0 , @game_2.home_goals
     assert_equal 'Centruy Link Field' , @game_2.venue
     assert_equal '/api/v1/venues/null',  @game_2.venue_link
  end
end
