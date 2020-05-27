require './test/test_helper'
require './lib/team'
require 'csv'

class TeamTest < Minitest::Test

  def setup
    team_data = {team_id: 1,
                franchiseid: 23,
                teamname: "Atlanta United",
                abbreviation: "ATL",
                stadium: "Mercedes_Benz Stadium",
                link: "/api/v1/teams/1"
              }
    @team = Team.new(team_data)
  end

  def test_its_values
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchiseid
    assert_equal "Atlanta United", @team.teamname
    assert_equal "ATL", @team.abbreviation
    assert_equal "Mercedes_Benz Stadium", @team.stadium
    assert_equal "/api/v1/teams/1", @team.link
  end

  def test_it_can_pull_from_csv
    team_data_2 = CSV.read("./data/teams.csv", headers: true, header_converters: :symbol)
    team_1 = Team.new(team_data_2[0])

    assert_equal "1", team_1.team_id
    assert_equal "23", team_1.franchiseid
    assert_equal "Atlanta United", team_1.teamname
    assert_equal "ATL", team_1.abbreviation
    assert_equal "Mercedes-Benz Stadium", team_1.stadium
    assert_equal "/api/v1/teams/1", team_1.link
  end
end
