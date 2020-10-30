require_relative './test_helper'
require './lib/team'
require 'csv'
require 'mocha/minitest'


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

  def test_team_info
    team = @teams.first
    expected = {"team_id"=>"1",
                "franchise_id"=>"23",
                "team_name"=>"Atlanta United",
                "abbreviation"=>"ATL",
                "link"=>"/api/v1/teams/1"}

    assert_equal expected, team.team_info
  end
end
