require_relative 'test_helper'

class TeamsCollectionTest < Minitest::Test

  def setup
    @teams_collection = TeamsCollection.new('./data/dummy_teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamsCollection, @teams_collection
  end

  def test_it_initializes_attributes
    assert_equal 32, @teams_collection.teams.length
    assert_equal true, @teams_collection.teams.all? {|team| team.is_a?(Team)}
  end


  def test_it_can_get_name_of_team_by_id
    assert_equal "FC Dallas", @teams_collection.name_of_team_by_id("6")
    assert_equal "Los Angeles FC", @teams_collection.name_of_team_by_id("28")
  end 
  
  def test_it_knows_how_many_teams_there_are
    assert_equal 32, @teams_collection.count_of_teams
  end
end
