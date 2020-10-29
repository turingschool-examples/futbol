require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/teams_repo'
require 'mocha/minitest'

class TeamsRepoTest < Minitest::Test
  def setup
    teams_path = './data/teams.csv'

    locations = {
      teams: teams_path
    }
    @parent = mock("Stat_tracker")
    @teams_repo = TeamsRepo.new(locations[:teams], @parent)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Array, @teams_repo.teams
  end
end
