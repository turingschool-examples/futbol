# frozen_string_literal: true

require './test/test_helper'
require './lib/team_methods'

class TeamMethodsTest < Minitest::Test
  def test_it_exists
    teams = './data/teams.csv'
    team_methods = TeamMethods.new(teams)

    assert_instance_of TeamMethods, team_methods

    assert_equal './data/teams.csv', team_methods.teams
  end

  def test_it_can_count_teams
    teams = './data/teams.csv'

    team_methods = TeamMethods.new(teams)

    assert_equal 32, team_methods.count_of_teams
  end

  def test_it_can_find_team_name_with_team_id
    teams = './data/teams.csv'

    team_methods = TeamMethods.new(teams)

    assert_equal 'Reign FC', team_methods.find_by_id("54")
    assert_equal 'Sporting Kansas City', team_methods.find_by_id("5")
    assert_equal 'Houston Dynamo', team_methods.find_by_id("3")
  end
end
