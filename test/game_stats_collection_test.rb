require_relative 'test_helper'

class GameStatsCollectionTest < Minitest::Test
  def setup
    @game_stats_collection = GameStatsCollection.new("./test/fixtures/truncated_game_teams.csv")
  end

  def test_it_exists
    assert_instance_of GameStatsCollection, @game_stats_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_stats_collection.game_stats
    assert_equal 217, @game_stats_collection.game_stats.length
  end

end
