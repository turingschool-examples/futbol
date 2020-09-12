require "./test/test_helper"
require "./lib/games_manager"

class GamesManagerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv
    @games_manager = @stat_tracker.games_manager
  end

  def test_it_exists
    assert_instance_of GamesManager, @games_manager
  end

  def test_it_can_find_the_lowest_total_score
    assert_equal 1, @games_manager.lowest_total_score
  end

  def test_it_can_find_the_highest_total_score
    assert_equal 6, @games_manager.highest_total_score
  end

  def test_it_can_get_percentage_home_wins
      assert_equal 0.55, @games_manager.percentage_home_wins
  end

  def test_it_can_get_percentage_visitor_games_won
    assert_equal 0.30, @games_manager.percentage_visitor_wins
  end

  def test_it_can_count_total_games
    assert_equal 53, @games_manager.total_games
  end

  def test_it_can_show_count_of_games_by_season
    expected = {"20142015"=>16, "20172018"=>9, "20152016"=>5, "20132014"=>12, "20122013"=>4, "20162017"=>7}
    assert_equal expected, @games_manager.count_of_games_by_season
  end


end
