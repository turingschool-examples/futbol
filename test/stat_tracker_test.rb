require './test/test_helper'


class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exist

    assert_instance_of StatTracker, @stat_tracker
  end

  def test_StatTracker_can_find_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_the_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score

  end

  def test_average_goals_per_game
  
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

end
