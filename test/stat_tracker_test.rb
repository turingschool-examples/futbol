require './test/test_helper'
require './lib/stat_tracker'


class StatTrackerTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({
      games: "./test/fixtures/games_fixture.csv",
      teams: "./data/teams.csv",
      game_teams: "./test/fixtures/games_teams_fixture.csv"
      })
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_has_attributes
    assert_instance_of Game, @stat_tracker.games.first
    assert_instance_of Team, @stat_tracker.teams.first
    assert_instance_of GameTeam, @stat_tracker.game_teams.first
  end

  def test_percentage_home_wins
    assert_equal 0.64, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.27, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.09, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {"20122013" => 3,
                "20132014" => 3,
                "20172018" => 5}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_find_highest_scoring_game
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_find_lowest_scoring_game
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_can_find_average_goals
    assert_equal 4.09 , @stat_tracker.average_goals_per_game
  end

  def test_it_can_find_the_sum_of_goals_in_a_season
    assert_equal 19, @stat_tracker.sum_of_goals_in_a_season("20172018")
    assert_equal 14, @stat_tracker.sum_of_goals_in_a_season("20122013")
    assert_equal 12, @stat_tracker.sum_of_goals_in_a_season("20132014")
  end

  def test_it_return_season_average_goals
    assert_equal 3.8, @stat_tracker.average_of_goals_in_a_season("20172018")
    assert_equal 4.67, @stat_tracker.average_of_goals_in_a_season("20122013")
    assert_equal 4.0, @stat_tracker.average_of_goals_in_a_season("20132014")
  end

  def test_it_can_return_a_seaon_with_average_goals
    assert_equal ({"20172018" => 3.8, "20132014" => 4.0, "20122013" => 4.67}), @stat_tracker.average_goals_by_season
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_most_accurate_team
    assert_equal "Portland Thorns FC", @stat_tracker.most_accurate_team("20172018")
  end

  def test_it_can_find_least_accurate_team
    assert_equal "Orlando City SC", @stat_tracker.least_accurate_team("20172018")
  end

  def test_winningest_coach
    assert_equal "Paul Maurice", @stat_tracker.winningest_coach("20172018")
  end

  def test_worst_coach
    assert_equal "Bruce Boudreau", @stat_tracker.worst_coach("20172018")
  end

  def test_it_can_find_team_with_most_season_tackles
    assert_equal "Portland Thorns FC", @stat_tracker.most_tackles("20172018")
  end

  def test_it_can_find_team_with_least_season_tackles
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20172018")
  end
end
