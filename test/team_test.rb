require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest::Test
  def setup
    @team_data = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol)
    @teams = @team_data.map do |row|
      Team.new(row.to_h)
    end
  end

  def test_it_exists
    team = @teams.first

    assert_instance_of Team, team
  end

  def test_it_has_attributes

    assert_equal 1, @teams.first.team_id
    assert_equal 23, @teams.first.franchiseid
    assert_equal "Atlanta United", @teams.first.teamname
    assert_equal "ATL", @teams.first.abbreviation
    assert_equal "Mercedes-Benz Stadium", @teams.first.stadium
    assert_equal "/api/v1/teams/1", @teams.first.link
  end
end
