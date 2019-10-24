require './test/test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    test_paths = {
      games: "./test/data/game_sample.csv",
      teams: "./test/data/team_sample.csv",
      game_teams: "./test/data/game_teams_sample.csv"
    }
    @stat_tracker = StatTracker.from_csv(test_paths)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_games
    assert_instance_of GameCollection, @stat_tracker.game_repo
  end

  def test_count_of_games_by_season
    expected = {
      "20192020"=>2,
      "20202021"=>2,
      "20212022"=>2,
      "20222023"=>2,
      "20232024"=>2
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 5.8, @stat_tracker.average_goals_per_game
  end

  def test_highest_total_score
    assert_equal 12, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 3 ,@stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 4, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.30, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.50, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

end
