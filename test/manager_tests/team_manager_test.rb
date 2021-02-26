require "./test/test_helper"

class TeamManagerTest < Minitest::Test

  def setup
    @team_data = './data/teams.csv'

    @team_manager = TeamManager.new(@team_data)
  end

  def test_it_exists
    assert_instance_of TeamManager, @team_manager
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
