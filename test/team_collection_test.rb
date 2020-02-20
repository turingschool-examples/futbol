require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_collection'
require 'CSV'

class TeamCollectionTest < Minitest::Test

  def setup
    @team_file_path = './data/teams.csv'
    @team_collection = TeamCollection.new(@team_file_path)
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
    assert_equal 32, @team_collection.teams.length
  end
end
