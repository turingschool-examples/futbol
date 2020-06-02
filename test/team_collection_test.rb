require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_collection'
require './lib/team'
require 'pry'

class TeamCollectionTest < Minitest::Test

  def setup
    file = './data/teams_fixture.csv'
    @team_collection = TeamCollection.new(file)
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_can_return_teams
    assert_equal 5, @team_collection.all.count
  end

end
