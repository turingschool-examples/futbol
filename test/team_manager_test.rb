require "./test/test_helper"

class TeamManagerTest < Minitest::Test
  def setup
    
  end

  def test_it_exists
    assert_instance_of TeamManager, @team_manager
  end

  def test_can_pull_correct_info
    assert_equal [], @team_manager.load_data(@teams)
  end

  # def test_team_info
  #
  # end
  #
  # def test_best_season
  #
  # end
  #
  # def test_worst_season
  #
  # end
  #
  # def test_average_win_percentage
  #
  # end
  #
  # def test_most_goals_scored
  #
  # end
  #
  # def test_fewest_goals_scored
  #
  # end
  #
  # def test_favorite_opponent
  #
  # end
  #
  # def test_rival
  #
  # end
end
