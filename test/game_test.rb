require_relative 'test_helper'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.from_csv('./data/dummy_game.csv')
  end

  def test_it_exists
    assert_instance_of Game, @game.first
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game.first.game_id
    assert_equal 20122013, @game.first.season
    assert_equal "Postseason", @game.first.type
    assert_equal "5/16/13", @game.first.date_time
    assert_equal 3, @game.first.away_team_id
    assert_equal 6, @game.first.home_team_id
    assert_equal 2, @game.first.away_goals
    assert_equal 3, @game.first.home_goals
    assert_equal "Toyota Stadium", @game.first.venue
    assert_equal "/api/v1/venues/null", @game.first.venue_link
  end

  def test_it_can_find_highest_total_score
    assert_equal 5, Game.highest_total_score
  end

  def test_it_can_find_lowest_total_score
    assert_equal 3, Game.lowest_total_score
  end

  def test_it_can_find_average_goals_by_season
    expected = {
                20122013 => 5,
                20142015 => 3.5,
                20152016 => 5
                }

    assert_equal expected, Game.average_goals_by_season
    assert_instance_of Hash, Game.average_goals_by_season
  end

  def test_it_can_count_the_number_of_games_in_a_season
    assert_equal ({20122013=>1, 20152016=>2, 20142015=>2}), Game.count_of_games_by_season

    assert_instance_of Hash, Game.count_of_games_by_season
  end

  def test_it_can_calcualte_the_average_number_of_goals_per_game_accross_all_games
    assert_equal 4.4, Game.average_goals_per_game
  end

  def test_biggest_blowout
    assert_equal 1, Game.biggest_blowout
  end

  def test_it_can_calculate_the_percentage_of_games_that_end_in_a_tie
    assert_equal 20.0, Game.percentage_ties
  end
end
