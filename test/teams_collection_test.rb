require "minitest/autorun"
require "minitest/pride"
require "./lib/teams_collection"
require "./lib/teams"
require "csv"

class TeamsCollectionTest < MiniTest::Test

	def setup
    teams_csv_location = "./data/teams.csv"
    @teams_collection = TeamsCollection.new(teams_csv_location)
	end

	def test_it_exists
		assert_instance_of TeamsCollection, @teams_collection
	end

  def test_it_starts_empty_collection
    assert_equal [], @teams_collection.collection
  end

  def test_it_can_load_csv
    @teams_collection.load_csv
    assert_equal 32, @teams_collection.collection.count
    all_teams_object = @teams_collection.collection.all? do |object|
      object.is_a?(Teams)
    end
    assert_equal true, all_teams_object
  end
end
