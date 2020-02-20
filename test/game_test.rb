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

  def test_it_can_calculate_highest_total_score
    assert_equal 7, @game.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, @game.lowest_total_score
  end

  def test_it_can_find_biggest_blowout
    assert_equal 4, @game.biggest_blowout
  end

  def test_it_can_find_all_seasons
    assert_equal [20122013, 20132014], @game.find_all_seasons
  end

  def test_it_can_calculate_count_of_games_by_season
    assert_equal ({20122013=>51, 20132014=>29}), @game.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game
    assert_equal 4.01, @game.average_goals_per_game
  end

  def test_it_can_average_goals_by_season
    assert_equal ({20122013=>4.02, 20132014=>4.0}), @game.average_goals_by_season
  end
end
