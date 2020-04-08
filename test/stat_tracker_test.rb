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
    assert_equal 63.64, @stat_tracker.percentage_home_wins
  end

  def test_percentage_home_wins
    assert_equal 27.27, @stat_tracker.percentage_away_wins
  end

  def test_percentage_ties
    assert_equal ((1.0 / 11) * 100).round(2), @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {20122013 => 3,
                20132014 => 3,
                20172018 => 5}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_find_highest_scoring_game
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_find_lowest_scoring_game
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_can_return_sum_of_games_goals
    assert_equal 45, @stat_tracker.sum_of_goals
  end

  def test_it_can_find_average_goals
    assert_equal 4.09 , @stat_tracker.average_goals_per_game
  end

  def test_it_can_find_season
    assert_equal 20172018, @stat_tracker.by_season(20172018).first.season
  end

  def test_it_can_find_the_sum_of_goals_in_a_season
    assert_equal 19, @stat_tracker.sum_of_goals_in_a_season(20172018)
    assert_equal 14, @stat_tracker.sum_of_goals_in_a_season(20122013)
    assert_equal 12, @stat_tracker.sum_of_goals_in_a_season(20132014)
  end

  def test_it_return_season_average_goals
    assert_equal 3.8, @stat_tracker.average_of_goals_in_a_season(20172018)
    assert_equal 4.67, @stat_tracker.average_of_goals_in_a_season(20122013)
    assert_equal 4.0, @stat_tracker.average_of_goals_in_a_season(20132014)
  end


  def test_it_can_return_a_seaon_with_average_goals
    assert_equal ({20172018 => 3.8, 20132014 => 4.0, 20122013 => 4.67}), @stat_tracker.average_goals_by_season
  end
end
