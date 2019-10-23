require './test/test_helper'
require './lib/team'
require './lib/team_collection'

class TeamsCollectionTest < Minitest::Test

  def setup
    @team_collection = TeamCollection.new("./data/teams_sample.csv")
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_has_total_teams
    @team_collection.create_games('./data/teams_sample.csv')
    assert_equal 3, @team_collection.total_teams.length
  end

  def test_it_has_attributes
  end
end
