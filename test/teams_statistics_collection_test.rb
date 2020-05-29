require "minitest/autorun"
require "minitest/pride"
require "./lib/teams_statistics_collection"
require "./lib/teams"
require "csv"

class TeamsStatisticsCollectionTest < MiniTest::Test

	def setup
    teams_csv_location = "./data/teams.csv"
    @teams_statistics_collection = TeamsStatisticsCollection.new(teams_csv_location)
	end

	def test_it_exists
		assert_instance_of TeamsStatisticsCollection, @teams_statistics_collection
	end

	def test_it_has_attributes
    file_path = "./data/teams.csv"
		assert_equal file_path, @teams_statistics_collection.csv_location
	end

  def test_it_starts_empty_collection
    assert_equal [], @teams_statistics_collection.collection
  end

  def test_it_can_load_teams
    @teams_statistics_collection.load_teams
    assert_equal 32, @teams_statistics_collection.collection.count
    all_teams_object = @teams_statistics_collection.collection.all? do |object|
      object.is_a?(Teams)
    end
    assert_equal true, all_teams_object
  end
end
