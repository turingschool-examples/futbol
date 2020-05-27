require_relative 'test_helper'

class TeamCollectionTest < Minitest::Test

  def setup
    @team_collection = TeamCollection.new('./data/teams.csv')
    @team = @team_collection.teams[8]
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @team_collection.teams
    assert_equal 32, @team_collection.teams.length
  end

  def test_it_can_create_teams_from_csv
    assert_equal "8", @team.team_id
    assert_equal "1", @team.franchise_id
    assert_equal "New York Red Bulls", @team.team_name
    assert_equal "NY", @team.abbreviation
    assert_equal "Red Bull Arena", @team.stadium
    assert_equal "/api/v1/teams/8", @team.link
  end
end
