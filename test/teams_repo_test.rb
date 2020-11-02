require './test/test_helper'

class TeamsRepoTest < Minitest::Test
  def setup
    @teams_path = './dummy_data/teams_dummy.csv'
    @teams_repo_test = TeamsRepo.new(@teams_path)
  end

  def test_make_teams
    assert_instance_of Teams, @teams_repo_test.make_teams(@teams_path)[0]
    assert_instance_of Teams, @teams_repo_test.make_teams(@teams_path)[-1]
  end

end  
