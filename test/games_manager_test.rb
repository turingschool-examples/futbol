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

  def test_it_can_return_all_game_ids_for_season
    expected = ["2012020030", "2012020133", "2012020355", "2012020389"]
    assert_equal expected, @games_manager.game_ids_by_season("20122013")
  end

  def test_it_can_count_total_home_wins
    assert_equal 1, @games_manager.team_wins_as_home("1", "20142015")
    assert_equal 1, @games_manager.team_wins_as_home("4", "20142015")
    assert_equal 3, @games_manager.team_wins_as_home("6", "20142015")
    assert_equal 0, @games_manager.team_wins_as_home("14", "20142015")
    assert_equal 2, @games_manager.team_wins_as_home("26", "20142015")
  end

  def test_it_can_count_total_away_wins
    assert_equal 1, @games_manager.team_wins_as_away("1", "20142015")
    assert_equal 2, @games_manager.team_wins_as_away("4", "20142015")
    assert_equal 1, @games_manager.team_wins_as_away("6", "20142015")
    assert_equal 1, @games_manager.team_wins_as_away("26", "20142015")
  end

  def test_it_can_count_total_number_of_wins_per_season
    assert_equal 2, @games_manager.total_team_wins("1", "20142015")
    assert_equal 3, @games_manager.total_team_wins("4", "20142015")
    assert_equal 4, @games_manager.total_team_wins("6", "20142015")
    assert_equal 3, @games_manager.total_team_wins("26", "20142015")
  end

  def test_it_can_count_total_games_for_team_in_season
    assert_equal 7, @games_manager.total_team_games_per_season("1", "20142015")
    assert_equal 7, @games_manager.total_team_games_per_season("4", "20142015")
    assert_equal 6, @games_manager.total_team_games_per_season("6", "20142015")
    assert_equal 5, @games_manager.total_team_games_per_season("14", "20142015")
    assert_equal 7, @games_manager.total_team_games_per_season("26", "20142015")
  end

  def test_it_can_determine_season_win_percentage
    assert_equal 28.57, @games_manager.season_win_percentage("1", "20142015")
    assert_equal 42.86, @games_manager.season_win_percentage("4", "20142015")
    assert_equal 66.67, @games_manager.season_win_percentage("6", "20142015")
    assert_equal 42.86, @games_manager.season_win_percentage("26", "20142015")
  end

  def test_it_can_return_array_of_seasons
    expected = ["20122013", "20132014", "20142015", "20152016", "20162017", "20172018"]
    assert_equal expected, @games_manager.all_seasons
  end


end
