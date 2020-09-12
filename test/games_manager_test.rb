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

  def test_it_can_count_total_team_wins
    expected = {
      "1" => 9,
      "4" => 7,
      "6" => 12,
      "14" => 8,
      "26" => 9
    }
    assert_equal expected, @games_manager.total_team_wins
  end

  def test_it_can_count_total_of_team_wins_by_season
    skip 
    expected = {
      "1" => {
        "20122013" => 2,
        "20132014" => 2,
        "20142014" => 2,
        "20152016" => 1,
        "20162017" => 1,
        "20172018" => 1
      },
      "4" => {
        "20122013" => 1,
        "20132014" => 2,
        "20142015" => 3,
        "20152016" => 1,
        "20162017" => 0,
        "20172018" => 0
      },
      "6" => {
        "20122013" => 1,
        "20132014" => 2,
        "20142015" => 4,
        "20152016" => 2,
        "20162017" => 1,
        "20172018" => 2
      },
      "14" => {
        "20122013" => 0.0,
        "20132014" => 25.0,
        "20142015" => 0.0,
        "20152016" => 100.0,
        "20162017" => 60.0,
        "20172018" => 60.0
      },
      "26" => {
        "20122013" => 0,
        "20132014" => 2,
        "20142015" => 3,
        "20152016" => 0,
        "20162017" => 1,
        "20172018" => 3
      }
    }
    assert_equal expected, @games_manager.total_team_wins_by_season
  end

  def test_it_can_calculate_percentage_wins_by_season
    skip
    expected = {
      1 => {
        "20122013" => 100.0,
        "20132014" => 40.0,
        "20142015" => 28.57,
        "20152016" => 50.0,
        "20162017" => 25.0,
        "20172018" => 33.33
      },
      4 => {
        "20122013" => 25.0,
        "20132014" => 40.0,
        "20142015" => 42.86,
        "20152016" => 33.33,
        "20162017" => 0.0,
        "20172018" => 0.0
      },
      6 => {
        "20122013" => 100.0,
        "20132014" => 50.0,
        "20142015" => 66.67,
        "20152016" => 66.67,
        "20162017" => 50.0,
        "20172018" => 50.0
      },
      14 => {
        "20122013" => 0.0,
        "20132014" => 25.0,
        "20142015" => 0.0,
        "20152016" => 100.0,
        "20162017" => 60.0,
        "20172018" => 60.0
      },
      26 => {
        "20122013" => 0.0,
        "20132014" => 33.33,
        "20142015" => 42.86,
        "20152016" => 0.0,
        "20162017" => 50.0,
        "20172018" => 75.0
      },
    }
  end

  def test_it_can_count_total_games
    assert_equal 53, @games_manager.total_games
  end

  def test_it_can_show_count_of_games_by_season
    expected = {"20142015"=>16, "20172018"=>9, "20152016"=>5, "20132014"=>12, "20122013"=>4, "20162017"=>7}
    assert_equal expected, @games_manager.count_of_games_by_season
  end


end
