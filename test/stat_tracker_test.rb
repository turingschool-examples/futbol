require "./test/test_helper"
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
      2014020774 => 4,
      2017020012 => 2
    }
    assert_equal expected, @stats.sum_game_goals
  end

  def test_it_can_determine_highest_and_lowest_game_score
    assert_equal 2, @stats.lowest_total_score
    assert_equal 6, @stats.highest_total_score
  end

  def test_it_can_find_total_games
    assert_equal 6, @stats.total_games
  end

  def test_it_can_find_percentage
    wins = ["game1", "game2", "game3"]
    assert_equal 50.00, @stats.find_percent(wins, 6)
  end

  def test_it_can_get_team_name_from_team_id
    assert_equal "Chicago Fire", @stats.team_names_by_team_id(4)
  end

  def test_it_can_get_total_scores_by_team
    expected = {"1"=>6, "4"=>2, "14"=>4, "6"=>8, "26"=>4}
    assert_equal expected, @stats.total_scores_by_team
  end

  def test_it_can_get_number_of_games_by_team
    expected = {"1"=>3, "4"=>2, "14"=>2, "6"=>3, "26"=>2}
    assert_equal expected, @stats.games_containing_team
  end

  def test_it_can_get_average_scores_per_team
    expected = {"1"=>2.0, "4"=>1.0, "14"=>2.0, "6"=>2.67, "26"=>2}
    assert_equal expected, @stats.average_scores_by_team
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

# ~~~ LEAGUE METHOD TESTS~~~


# ~~~ SEASON METHOD TESTS~~~


# ~~~ TEAM METHOD TESTS~~~
end
