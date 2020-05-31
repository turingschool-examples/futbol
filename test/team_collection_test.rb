require './test/test_helper'
require './lib/team'
require './lib/team_collection'


class TeamCollectionTest < Minitest::Test

  def setup
    @team_collection = TeamCollection.new('./data/teams.csv')
    @team = @team_collection.teams_array.first
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @team_collection.teams_array
    assert_equal 32, @team_collection.teams_array.length
  end

end
