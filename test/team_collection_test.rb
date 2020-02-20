require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_collection'


class TeamCollectionTest < Minitest::Test
  def setup
    @csv_file_path = "./test/fixtures/teams_truncated.csv"
    @team_collection = TeamCollection.new(@csv_file_path)
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_has_attributes
    assert_equal [], @team_collection.teams
    assert_equal "./test/fixtures/teams_truncated.csv", @team_collection.csv_file_path
  end
end
