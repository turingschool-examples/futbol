require_relative 'test_helper'

class TeamsCollectionTest < Minitest::Test

  def setup
    @team_1 = Team.new
    @team_2 = Team.new
    @teams_array = [@team_1, @team_2]
    @teams_collection = TeamsCollection.new(@teams_array)
  end

  def test_it_exists
    assert_instance_of TeamsCollection, @teams_collection
  end

  def test_it_initializes_attributes
    assert_equal @teams_array, @teams_collection.teams
  end
end
