require "./test/test_helper"
require "mocha/minitest"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    @stats = StatTracker.from_csv
  end

  def test_it_is_a_stat_tracker
    assert_instance_of StatTracker, @stats
  end

  def test_it_has_access_to_other_classes
    assert_instance_of Game, @stats.games[0]
    assert_equal 53, @stats.games.count
    assert_instance_of Team, @stats.teams[0]
    assert_equal 5, @stats.teams.count
    assert_instance_of GameTeam, @stats.game_teams[0]
    assert_equal 106, @stats.game_teams.count
  end

  # ~~~ HELPER METHOD TESTS~~~

  def test_it_can_sum_goals_per_game ###
    expected = {
      2014020006=>6, 2014021002=>4, 2014020598=>3, 2014020917=>5, 2014020774=>4,
      2014020142=>5, 2014020981=>5, 2014020970=>5, 2014020002=>3, 2014020391=>3,
      2014020423=>3, 2014020643=>6, 2014020371=>2, 2014020845=>5, 2014021083=>4}
    assert_equal expected, @stats.sum_game_goals("20142015")
  end

  def test_it_can_determine_highest_and_lowest_game_score ###
    assert_equal 1, @stats.lowest_total_score
    assert_equal 6, @stats.highest_total_score
  end

  def test_it_can_find_total_games ###
    assert_equal 53, @stats.total_games
  end

  def test_it_can_determine_season_win_percentage
    # expected = {"20142015" => 4}
    # @stats.stubs(:count_of_games_by_season).returns(expected)
    assert_equal 18.75, @stats.season_win_percentage(1, "20142015")
    assert_equal 31.25, @stats.season_win_percentage(4, "20142015")
    assert_equal 43.75, @stats.season_win_percentage(6, "20142015")
    assert_equal 37.5, @stats.season_win_percentage(26, "20142015")
  end

# ~~~ GAME METHOD TESTS~~~
  def test_it_can_get_percentage_away_games_won ###
    assert_equal 30.19, @stats.percentage_away_wins
  end

  def test_it_can_get_percentage_ties ###
    assert_equal 15.09, @stats.percentage_ties
  end

  def test_it_can_get_percentage_home_wins ###
    assert_equal 54.72, @stats.percentage_home_wins
  end

  def test_it_can_see_count_of_games_by_season ###
    expected = {"20142015"=>16, "20172018"=>9, "20152016"=>5, "20132014"=>12, "20122013"=>4, "20162017"=>7}

    assert_equal expected, @stats.count_of_games_by_season
  end

  def test_it_can_determine_highest_and_lowest_game_score
    assert_equal 2, @stats.lowest_total_score("20142015")
    assert_equal 6, @stats.highest_total_score("20142015")
  end

# ~~~ LEAGUE METHOD TESTS~~~


# ~~~ SEASON METHOD TESTS~~~


# ~~~ TEAM METHOD TESTS~~~
end
