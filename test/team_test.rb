require_relative 'test_helper'
require_relative '../lib/team'

class TeamTest < Minitest::Test

  def setup
    row = {team_id: 30,
          franchiseId: 37,
          teamName: "Orlando City SC",
          abbreviation: "ORL"
          }
    @team = Team.new(row)
  end

  def test_it_exists
     assert_instance_of Team, @team
  end

  def test_it_has_attributes

    assert_equal 30, @team.team_id
    assert_equal 37, @team.franchise_id
    assert_equal "Orlando City SC", @team.team_name
    assert_equal "ORL", @team.abbreviation
  end
end
