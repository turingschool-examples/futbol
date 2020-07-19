require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/teams_collection'
require 'csv'

class TeamsCollectionTest < Minitest::Test

  def test_it_exists
    teams_collection = TeamsCollection.new('./data/teams.csv')

    assert_instance_of TeamsCollection, teams_collection
  end

  def test_it_has_attributes
    teams_collection = TeamsCollection.new('./data/teams.csv')

    assert_equal './data/teams.csv', teams_collection.path
  end

end
