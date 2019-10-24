require 'csv'
require './test/test_helper'
require './lib/team'

class TeamsTest < Minitest::Test

  def setup
    csv = CSV.read('./data/teams_sample.csv', headers: true, header_converters: :symbol)
    @teams = csv.map do |row|
      Team.new(row)
    end
  end

  def test_it_exists
    @teams.each do |team|
      assert_instance_of Team, team
    end
  end

  def test_it_has_attributes
    team = @teams.first

    assert_equal 1, team.team_id
    assert_equal 23, team.franchise_id
    assert_equal "Atlanta United", team.team_name
    assert_equal "ATL", team.abbreviation
    assert_equal "Mercedes-Benz Stadium", team.stadium
    assert_equal "/api/v1/teams/1", team.link
  end
end
