require_relative 'test_helper'
require 'csv'
require './lib/games_methods'

class GameStatsTest < Minitest::Test
  def setup
    @games = Games.new("./data/games_truncated.csv")
    @game = @games.games.first
  end

  def test_it_exists
    assert_instance_of Games, @games
  end

  def test_it_has_attributes
    assert_instance_of Array, @games.games
    assert_equal 59, @games.games.length
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Games, @games
    assert_equal 3, @game.away_team_id
    assert_equal 2012030221, @game.game_id
  end

  def test_highest_total_score
    assert_equal 6, @games.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @games.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal ((38/59.to_f)*100).round(2), @games.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal ((19/59.to_f)*100).round(2), @games.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal ((2/59.to_f)*100).round(2), @games.percentage_ties
  end

  def test_count_games_by_season
    expected = {20122013=>57, 20162017=>2}
    assert_equal expected, @games.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.898, @games.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {20122013=>3.86, 20162017=>5.0}
    assert_equal expected, @games.average_goals_by_season
  end

end
