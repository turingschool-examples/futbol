require './test/test_helper'

class TeamManagerTest < Minitest::Test
  def setup
    @team_data = TeamManager.new('data/teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamManager, @team_data
  end

  def test_count_of_teams
    assert_equal 32, @team_data.count_of_teams
  end

  # def test_find_team_by_id
  #   binding.pry
  #   assert_equal , @team_data.find_team_by_id("3")
  # end
end
