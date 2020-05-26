require './test/helper_test'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    @atlanta = Team.new({
      team_id: "1",
      franchise_id: "23",
      team_name: "Atlanta United",
      abbreviation: "ATL",
      stadium: "Mercedes-Benz Stadium",
      link: "/api/v1/teams/1"
    })
    end

    def test_it_exists
      assert_instance_of Team, @atlanta
    end

    def test_it_has_team_info_attributes

      assert_equal "1", @atlanta.team_id
      assert_equal "23", @atlanta.franchise_id
      assert_equal "Atlanta United", @atlanta.team_name
      assert_equal "ATL", @atlanta.abbreviation
      assert_equal "Mercedes-Benz Stadium", @atlanta.stadium
      assert_equal "/api/v1/teams/1", @atlanta.link
    end
  end
