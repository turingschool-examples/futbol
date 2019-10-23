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
end
