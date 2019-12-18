require_relative 'testhelper'
require_relative '../lib/team'

class TeamTest < Minitest::Test
    def test_it_exists
        team = Team.new({})
        assert_instance_of Team, team
    end

    def test_it_has_attrubutes
        team = Team.new({ team_id: 1,
                        franchiseId: 23,
                        teamName: "Atlanta United",
                        abbreviation: "ATL",
                        stadium: "Mercedes-Benz Stadium" })

        assert_equal 1, team.team_id
        assert_equal 23, team.franchiseId
        assert_equal "Atlanta United", team.teamName
        assert_equal "ATL", team.abbreviation
        assert_equal "Mercedes-Benz Stadium", team.stadium
    end
end
