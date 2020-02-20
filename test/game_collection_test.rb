require_relative 'test_helper'
require './lib/game_collection'
require './lib/game'

class GameCollectionClass < Minitest::Test
  def setup
    file_path = './test/fixtures/truncated_games.csv'
    @game_collection = GameCollection.new(file_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_list_of_games
    assert_instance_of Array, @game_collection.games_list
    assert_instance_of Game, @game_collection.games_list.first
    assert_equal 299, @game_collection.games_list.length
  end

  def test_it_creates_pct_data
    expected = {
      total_games: 299,
      home_wins: 149,
      away_wins: 103,
      ties: 47
    }
    assert_equal expected, @game_collection.create_pct_data
  end

  def test_it_returns_home_win_pct
    @game_collection.create_pct_data
    assert_equal 49.83, @game_collection.pct_of_total_games(:home_wins)
  end

  def test_it_can_get_all_seasons
    season_test_list = ["20122013", "20162017", "20142015", "20152016", "20132014"]

    assert_equal season_test_list, @game_collection.get_all_seasons
  end

end
