require_relative 'test_helper'

class TeamCollectionTest < Minitest::Test
  def setup
    @team_collection = TeamCollection.new('./data/teams.csv')
    @team = @team_collection.teams[21]
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @team_collection.teams
    assert_equal 32, @team_collection.teams.length
  end

  def test_it_can_create_teams_from_csv
    assert_instance_of Team, @team
    assert_equal "VAN", @team.abbreviation
    assert_equal 0, @team.franchiseid
    assert_equal "/api/v1/teams/21", @team.link
    assert_equal 21, @team.team_id
    assert_equal "Vancouver Whitecaps FC", @team.teamname
  end
end
