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

  def test_it_can_read
    teams_collection = TeamsCollection.new('./data/teams.csv')
    teams_collection.from_csv('./data/teams.csv')

    assert_equal 32, teams_collection.all_teams.length
    assert_equal Team, teams_collection.all_teams[0].class
  end

  def test_it_can_add_teams
    teams_collection = TeamsCollection.new('./data/teams.csv')

    assert_equal [], teams_collection.all_teams
    teams_collection.add_team({})

    assert_equal 1, teams_collection.all_teams.length
  end
end
