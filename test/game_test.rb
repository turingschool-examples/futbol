require_relative 'test_helper'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @games = Game.create_games('./test/fixtures/games_truncated.csv')
    @game = Game.all[2]
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal 2012030223, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal 'Postseason', @game.type
    assert_equal '5/21/13', @game.date_time
    assert_equal 6, @game.away_team_id
    assert_equal 3, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 1, @game.home_goals
    assert_equal 'BBVA Stadium', @game.venue
    assert_equal '/api/v1/venues/null', @game.venue_link
  end


end
