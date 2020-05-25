require './test/helper_test'
require './lib/game'
require './lib/game_collection'
require './lib/game_stats'

class GameStatsTest < Minitest::Test
  def setup
    @games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game_stats = GameStats.new(@games_collection)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @game_stats.games_collection
  end
end
