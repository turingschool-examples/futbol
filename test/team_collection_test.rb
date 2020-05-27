require './test/helper_test'
require './lib/team'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test
  def setup
    @teams_collection = TeamCollection.new("./data/teams.csv")
  end

  def test_it_exists
    assert_instance_of TeamCollection, @teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @teams_collection.teams
  end

  def test_it_can_create_teams_objects
    assert_instance_of Team, @teams_collection.teams.first
  end
end
