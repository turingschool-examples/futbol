require 'minitest/autorun'
require 'minitest/pride'
require './lib/games_manager'
require './lib/game'
require './lib/stat_tracker'

class GamesManagerTest < Minitest::Test

  def setup
    games = './data/games_truncated.csv'

    new_data = CsvLoadable.new
    @games = new_data.load_csv_data(games, Game)
  end

  def test_it_exists
    games_manager = GamesManager.new(@games)

    assert_instance_of GamesManager, games_manager
  end

  def test_it_can_find_the_highest_total_score
    assert_equal 6, GamesManager.highest_total_score(@games)
  end

  def test_lowest_total_score
    assert_equal 1, GamesManager.lowest_total_score(@games)
  end
end
