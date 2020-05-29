require "minitest/autorun"
require "minitest/pride"
require "./lib/games_statistics_collection"
require "./lib/games"
require "csv"

class GameStatisticsCollectionTest < MiniTest::Test

	def setup
    games_csv_location = "./data/games.csv"
    @games_statistics_collection = GameStatisticsCollection.new(games_csv_location)
	end

	def test_it_exists
		assert_instance_of GameStatisticsCollection, @games_statistics_collection
	end

	def test_it_has_attributes
    file_path = "./data/games.csv"
		assert_equal file_path, @games_statistics_collection.csv_location
	end

  def test_it_starts_empty_collection
    assert_equal [], @games_statistics_collection.collection
  end

  def test_it_can_load_games
    @games_statistics_collection.load_games
    assert_equal 7441, @games_statistics_collection.collection.count
    all_games_object = @games_statistics_collection.collection.all? do |object|
      object.is_a?(Games)
    end
    assert_equal true, all_games_object
  end
end
