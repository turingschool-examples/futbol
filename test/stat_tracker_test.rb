require './test/test_helper'

class StatTrackerTest < MiniTest::Test

  def setup
    locations = {
      games: './data/fixture_files/games.csv',
      teams: './data/fixture_files/teams.csv',
      game_teams: './data/fixture_files/game_teams.csv'
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

# Game Statistics Methods
  def test_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 66.00, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 32.00, @stat_tracker.percentage_visitor_wins
  end

  def test_calc_percentage
    assert_equal 40.00, @stat_tracker.calc_percentage(2, 5)
  end

  def test_percentage_ties
    assert_equal 2.00, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    hash = {
      "20122013" => 57,
      "20132014" => 6,
      "20142015" => 17,
      "20152016" => 16,
      "20162017" => 4
    }
    assert_equal hash, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    avg = 3.95

    assert_equal avg, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    hash = {
      "20122013" => 3.86,
      "20132014" => 4.33,
      "20142015" => 4.00,
      "20152016" => 3.88,
      "20162017" => 4.75
    }

    assert_equal hash, @stat_tracker.average_goals_by_season
  end

  def test_winningest_coach
    assert_equal "Dan Bylsma", @stat_tracker.winningest_coach(20152016)
  end
end
