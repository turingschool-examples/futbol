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
    assert_equal 6, @stats.games.count
    assert_instance_of Team, @stats.teams[0]
    assert_equal 5, @stats.teams.count
    assert_instance_of GameTeam, @stats.game_teams[0]
    assert_equal 12, @stats.game_teams.count
  end

  # ~~~ HELPER METHOD TESTS~~~

  def test_it_can_sum_goals_per_game
    expected = {
      2014020006 => 6,
      2014021002 => 4,
      2014020598 => 3,
      2014020917 => 5,
      2014020774 => 4
    }
    assert_equal expected, @stats.sum_game_goals("20142015")
  end

  def test_it_can_filter_games_by_season
    @stats.games.delete_at(-1)
    expected = @stats.games
    assert_equal expected, @stats.filter_by_season("20142015")
  end

  def test_it_can_count_total_home_wins
    assert_equal 0, @stats.team_wins_as_home(1, "20142015")
    assert_equal 0, @stats.team_wins_as_home(4, "20142015")
    assert_equal 1, @stats.team_wins_as_home(6, "20142015")
    assert_equal 0, @stats.team_wins_as_home(26, "20142015")
  end

  def test_it_can_count_total_away_wins
    assert_equal 1, @stats.team_wins_as_away(1, "20142015")
    assert_equal 0, @stats.team_wins_as_away(4, "20142015")
    assert_equal 1, @stats.team_wins_as_away(6, "20142015")
    assert_equal 0, @stats.team_wins_as_away(26, "20142015")
  end

  def test_it_can_count_total_number_of_wins_per_season
    assert_equal 1, @stats.total_team_wins(1, "20142015")
    assert_equal 0, @stats.total_team_wins(4, "20142015")
    assert_equal 2, @stats.total_team_wins(6, "20142015")
    assert_equal 0, @stats.total_team_wins(26, "20142015")
  end

  def test_it_can_determine_season_win_percentage
    @stats.stubs(:count_of_games_by_season).returns(4)
    assert_equal 25, @stats.season_win_percentage(1, "20142015")
    assert_equal 0, @stats.season_win_percentage(4, "20142015")
    assert_equal 50, @stats.season_win_percentage(6, "20142015")
    assert_equal 0, @stats.season_win_percentage(26, "20142015")
  end

  def test_it_can_organize_season_win_percentage_for_teams
    expected {}

    assert_equal expected, @stats.season_percent_wins
  end

# ~~~ GAME METHOD TESTS~~~
  def test_it_can_get_percentage_away_games_won
    assert_equal 33.33, @stats.percentage_away_wins
  end

  def test_it_can_get_percentage_ties
    assert_equal 33.33, @stats.percentage_ties
  end

  def test_it_can_get_percentage_home_wins
    assert_equal 33.33, @stats.percentage_home_wins
  end

  def test_it_can_determine_highest_and_lowest_game_score
    assert_equal 3, @stats.lowest_total_score("20142015")
    assert_equal 6, @stats.highest_total_score("20142015")
  end


  def test_it_can_list_winningest_coach_by_season
    skip
  end

# ~~~ LEAGUE METHOD TESTS~~~


# ~~~ SEASON METHOD TESTS~~~


# ~~~ TEAM METHOD TESTS~~~
end
