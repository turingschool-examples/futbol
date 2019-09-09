require_relative 'test_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/games'
require_relative '../lib/teams'
require_relative '../lib/game_teams'


class LeagueStatsSupportTest < MiniTest::Test

  def setup
    locations = { games: './data/dummy_games.csv', teams: './data/dummy_teams.csv', game_teams: './data/dummy_game_teams.csv' }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_generate_num_goals_per_team

  example = {
    "3" => 7,
    "6" => 11,
    "8" => 5,
    "9" => 9,
      "20" => 9,
      "24" => 15
    }

    assert_equal example, @stat_tracker.generate_num_goals_per_team
  end

  def test_generate_num_games_per_team

    example_1 = {
      "3" => 4,
      "6" => 4,
      "8" => 3,
      "9" => 3,
      "20" => 5,
      "24" => 5
    }

    example_2 = {
      "3" => 2,
      "6" => 2,
      "8" => 2,
      "9" => 1,
      "20" => 2,
      "24" => 3
    }

    example_3 = {
      "3" => 2,
      "6" => 2,
      "8" => 1,
      "9" => 2,
      "20" => 3,
      "24" => 2
    }

    assert_equal [example_1, example_2, example_3], @stat_tracker.generate_num_games_per_team
  end

  def test_generate_average
    averages = {
      "3" => 1.75,
      "6" => 2.75,
      "8" => 1.67,
      "9" => 3.0,
      "20" => 1.8,
      "24" => 3.0
    }

    averages_home = {
      "6" => 3.0,
      "9" => 3.5,
      "24" => 3.0,
      "3" => 1.5,
      "20" => 1.67,
      "8" => 2.0,
    }

    averages_away = {
      "3" => 2.0,
      "8" => 1.5,
      "20" => 2.0,
      "6" => 2.5,
      "24" => 3.0,
      "9" => 2.0
    }

    assert_equal [averages, averages_home, averages_away], @stat_tracker.generate_average_goals
  end

  def test_generate_allowed_goals
    example = {
      "6" => 7,
      "3" => 11,
      "9" => 5,
      "8" => 9,
      "24" => 9,
      "20" => 15
    }


    assert_equal example, @stat_tracker.generate_allowed_goals
  end

  def test_generate_average_allowed
    example = {
      "6" => 1.75,
      "3" => 2.75,
      "9" => 1.6666666666666667,
      "8" => 3.0,
      "24" => 1.8,
      "20" => 3.0
    }

    assert_equal example, @stat_tracker.generate_average_allowed
  end

  def test_generate_home_and_away_goals
    home_goals = {
      "3" => 4,
      "8" => 3,
      "20" => 4,
      "6" => 5,
      "24" => 9,
      "9" => 2
    }

    away_goals = {
      "6" => 6,
      "9" => 7,
      "24" => 6,
      "3" => 3,
      "20" => 5,
      "8" => 2
    }

    example = [home_goals, away_goals]

    assert_equal example, @stat_tracker.generate_home_and_away_goals
  end

  def test_highest_scoring_visitor
    assert_equal "24", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
  assert_equal "20", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "9", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "8", @stat_tracker.lowest_scoring_home_team
  end

  def test_generate_wins

    team_wins = {
      "3" => 0,
      "6" => 4,
      "8" => 0,
      "9" => 2,
      "20" => 0,
      "24" => 5
    }

    home_wins = {
      "3" => 0,
      "6" => 2,
      "8" => 0,
      "9" => 2,
      "20" => 0,
      "24" => 2
    }

    away_wins = {
      "3" => 0,
      "6" => 2,
      "8" => 0,
      "9" => 0,
      "20" => 0,
      "24" => 3
    }


    example = [away_wins, home_wins, team_wins]
    assert_equal example, @stat_tracker.generate_wins
  end

  def test_calculate_percents
    percent_away = {
      "3" => 0.0,
      "6" => 100.0,
      "8" => 0.0,
      "9" => 0.0,
      "20" => 0.0,
      "24" => 100.0
    }

    percent_home = {
      "3" => 0.0,
      "6" => 100.0,
      "8" => 0.0,
      "9" => 66.67,
      "20" => 0.0,
      "24" => 100.0
    }

    percent_team = {
      "3" => 0.0,
      "6" => 100.0,
      "8" => 0.0,
      "9" => 100.0,
      "20" => 0.0,
      "24" => 100.0
    }

    example = [percent_away, percent_team, percent_home]
    assert_equal example, @stat_tracker.calculate_percents
  end
end
