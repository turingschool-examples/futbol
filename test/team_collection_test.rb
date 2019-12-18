require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/team_collection'

class TeamCollectionTest < Minitest::Test
    
  def setup
    collection = TeamCollection.new
  end
    
  def test_team_collection_exists
    assert_instance_of TeamCollection, collection
  end

  def test_team_collection_has_team_instance_variable
    assert_nil collection.team
  end

  def test_file_path_locations
    assert_equal './data/team.csv', collection.team_file_path
  end

  def test_team_collection_can_have_csv_data_added
    refute_nil collection.from_csv
  end
end
