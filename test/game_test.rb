require './test/test_helper'
require './lib/game'
require 'CSV'
require 'pry'

class GameTest < Minitest::Test

  def setup
    @csv_games = CSV.read('./data/games_fixture.csv', headers: true, header_converters: :symbol)
    @game = Game.new(@csv_games[0])
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_readable_attributes
    assert_equal "2012030221", @game.game_id
    assert_equal "20122013", @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal "3", @game.away_team_id
    assert_equal "6", @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Toyota Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end
end

# game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link
#
# 2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null
