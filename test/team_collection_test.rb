require './test/test_helper'
require './lib/team'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test
  def setup
    @teams_collection = TeamCollection.new("./data/teams.csv")
    @teams = @teams_array.create_teams_array.first
  end

  def test_it_exists
    assert_instance_of TeamCollection, @teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @teams_collection.teams_collection
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Team, @teams
    assert_equal "1", @teams.team_id
    assert_equal "Atanta United", @teams.team_name
  end
end
