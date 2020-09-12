require 'minitest/autorun'
require 'minitest/pride'
require 'Pry'
require './lib/team'

class TeamTest < Minitest::Test
  def test_it_exists
    data = CSV.read('./data/teams_dummy.csv', headers:true)
    team = Team.new(data[0], "manager")

    assert_instance_of Team, team
    assert_instance_of CSV::Table, data
  end

  def test_it_has_attributes
    data = CSV.read('./data/teams_dummy.csv', headers:true)
    team = Team.new(data[0], "manager")

    assert_equal "5", team.team_id
    assert_equal "23", team.franchise_id
    assert_equal "Atlanta United", team.team_name
    assert_equal "ATL", team.abbreviation
    assert_equal "Mercedes-Benz Stadium", team.stadium
    assert_equal "/api/v1/teams/1", team.link
  end
end
