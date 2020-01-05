require './test/test_helper'
require './lib/game_collection'
require './lib/game_stats'


class GameStatsTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game_stats = GameStats.new(@game_collection)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @game_stats.game_collection
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal  4.31, @game_stats.average_goals_per_game
  end

  def test_it_can_calculate_average_goals
    assert_equal 4.31, @game_stats.average_goals(@game_collection.games)
  end

  def test_it_can_calculate_average_goals_by_season
    avg_goals_by_season = @game_stats.average_goals_by_season
    assert_equal 4.33, avg_goals_by_season["20132014"]
    assert_equal 3.5, avg_goals_by_season["20142015"]
    assert_equal 4.6, avg_goals_by_season["20152016"]
    assert_equal 4.75, avg_goals_by_season["20162017"]
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.38, @game_stats.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.58, @game_stats.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.04, @game_stats.percentage_ties
  end

  def test_it_can_get_the_sum_of_highest_winning_and_losing_team_score
    assert_equal 7, @game_stats.highest_total_score
  end

  def test_it_can_get_the_sum_of_lowest_winning_and_losing_team_score
    assert_equal 2, @game_stats.lowest_total_score
  end

  def test_it_can_get_biggest_blowout
    assert_equal 3, @game_stats.biggest_blowout
  end
end
