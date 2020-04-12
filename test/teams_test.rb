require_relative 'test_helper'
require 'csv'
require './lib/teams'
require './lib/team'

class TeamsTest < Minitest::Test
  def setup
    @teams = Teams.new("./data/teams.csv")
    @team = @teams.teams.first
  end

  def test_it_exists
    assert_instance_of Teams, @teams
  end

  def test_it_can_create_teams_from_csv
    assert_instance_of Team, @team
    assert_equal 1, @team.team_id
    assert_equal "Atlanta United", @team.name
  end
end
