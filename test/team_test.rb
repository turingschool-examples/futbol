require_relative './test_helper'
require './lib/team'


class TeamTest < Minitest::Test

  def setup
    @teams = []
    CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
      @teams << Team.new(row, self)
    end
  end

  def test_it_exists_and_has_attributes
    team = @teams.first
    assert_instance_of Team, team
    assert_equal "1", team.team_id
    assert_equal "23", team.franchiseid
    assert_equal "Atlanta United", team.teamname
    assert_equal "ATL", team.abbreviation
    assert_equal "Mercedes-Benz Stadium", team.stadium
  end
end
