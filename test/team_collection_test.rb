require './test/test_helper'
require './lib/team'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test
  def setup
    @teams_collection = TeamCollection.new("./data/teams.csv")
    @team = @teams_collection.teams_array.first
  end

  def test_it_exists
    assert_instance_of TeamCollection, @teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @teams_collection.teams_array
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Team, @team
    assert_equal "1", @team.team_id
    assert_equal "Atlanta United", @team.team_name
  end
end
