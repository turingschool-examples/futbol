require_relative 'test_helper'
require './lib/data_loadable'
require './lib/game'
require './lib/game_stats'

class GameStatsTest < Minitest::Test

  def setup
    @games_stats = GameStats.new("./data/games_truncated.csv", Game)
    @game = @games_stats.games[1]
  end

  def test_it_exists
    assert_instance_of GameStats, @games_stats
  end

  def test_game_objects_are_new_instances_of_game_class
    assert_instance_of Game, @games_stats.games.first
  end

  def test_attributes_for_instance_of_game_withing_game_stats
    assert_equal 2013030411, @game.game_id
    assert_equal 20132014, @game.season
    assert_equal "Postseason", @game.type
    assert_equal 3, @game.away_team_id
    assert_equal 26, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 14.29, @games_stats.percentage_ties
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 57.14, @games_stats.percentage_home_wins
  end

  def test_it_can_count_games_by_season
    games_by_season = {
      20152016 => 3,
      20132014 => 2,
      20142015 => 1,
      20162017 => 1
    }

    assert_equal games_by_season, @games_stats.count_of_games_by_season
  end

  def test_it_can_calculate_percentage_vistor
    assert_equal 28.57, @games_stats.percentage_visitor_wins
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 4.71, @games_stats.average_goals_per_game
  end

  def test_it_can_calculate_average_goals_per_season
    goals_by_season = { 20152016 => 5.33, 20132014 => 5, 20142015 => 3,
                        20162017 => 4}
    assert_equal goals_by_season, @games_stats.average_goals_by_season
  end

  def test_returns_highest_total_score
    assert_equal 6, @games_stats.highest_total_score
  end

  def test_returns_lowest_total_score
    assert_equal 3, @games_stats.lowest_total_score
  end

  def test_returns_biggest_blowout
    assert_equal 2, @games_stats.biggest_blowout
  end
end
