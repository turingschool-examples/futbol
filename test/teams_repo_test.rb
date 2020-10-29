require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/teams_repo'
require 'mocha/minitest'
require './lib/team'

class TeamsRepoTest < Minitest::Test
  def setup
    teams_path = './data/teams.csv'

    locations = {
      teams: teams_path
    }
    @parent = mock()
    @teams_repo = TeamsRepo.new(locations[:teams], @parent)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Array, @teams_repo.teams
    assert mock(), @parent
  end

  def test_create_team
    assert_instance_of Team, @teams_repo.teams[0]
  end
end
