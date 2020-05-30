require './test/helper_test'
require './lib/game'
require './lib/game_collection'
require './lib/game_stats'


class GameStatsTest < Minitest::Test
  def setup
    @games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game_stats = GameStats.new(@games_collection)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @game_stats.games_collection
  end

  def test_it_has_total_score
    assert_instance_of Array , @game_stats.total_score
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 8, @game_stats.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 1, @game_stats.lowest_total_score
  end

  def test_it_has_percentage_home_wins
    assert_equal 0.5, @game_stats.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 0.34, @game_stats.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 0.16, @game_stats.percentage_ties
  end

  def test_it_has_games_by_season
    assert_instance_of Hash, @game_stats.games_by_season
  end

  def test_it_has_count_of_games_by_season
    expected = {"20122013"=>40, "20132014"=>40, "20142015"=>40, "20152016"=>40, "20162017"=>40, "20172018"=>40}
    assert_equal expected, @game_stats.count_of_games_by_season
  end

  def test_it_has_average_goals_per_game
    assert_equal 4.20, @game_stats.average_goals_per_game
  end

  def test_it_has_average_goals_by_season
    expected = {"20122013"=>4.18, "20132014"=>4.05, "20142015"=>4.23, "20152016"=>4.05, "20162017"=>4.3, "20172018"=>4.4}
    assert_equal expected, @game_stats.average_goals_by_season
  end
end
