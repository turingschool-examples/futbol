require_relative 'test_helper'
require './lib/team'


class TeamTest < Minitest::Test

  def setup
    @teams = Team.create_teams('./data/teams.csv')
    @team = Team.all[2]
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_attributes
    assert_equal 26, @team.team_id
    assert_equal 14, @team.franchise_id
    assert_equal 'FC Cincinnati', @team.team_name
    assert_equal 'CIN', @team.abbreviation
    assert_equal 'Nippert Stadium', @team.stadium
    assert_equal '/api/v1/teams/26', @team.link

  end

 end
