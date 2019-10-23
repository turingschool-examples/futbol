require './test/test_helper'
require './lib/team'
require './lib/team_collection'

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
    assert_equal 1, @teams.first.team_id
    assert_equal 23, @teams.first.franchise_id
    assert_equal "Atlanta United", @teams.first.team_name
    assert_equal "ATL", @teams.first.abbreviation
    assert_equal "Mercedes-Benz Stadium", @teams.first.stadium
    assert_equal "/api/v1/teams/1", @teams.first.link
  end
end
