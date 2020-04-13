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
    assert_equal 18, @game_collection.games_list.length
  end

  def test_total_scores
    expected = [3, 5, 3, 8, 6, 6, 5, 5, 1, 2, 5, 4, 3, 7, 5, 3, 3, 3]
    assert_equal expected, @game_collection.total_scores
  end

  def test_highest_total_score
    assert_equal 8, @game_collection.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @game_collection.lowest_total_score
  end

  def test_home_wins
    assert_equal 12, @game_collection.home_wins
  end

  def test_away_wins
    assert_equal 6, @game_collection.away_wins
  end

  def test_ties
    assert_equal 0, @game_collection.ties
  end

  def test_percentage_home_wins
    assert_equal 0.67, @game_collection.percentage_home_wins
  end

  def test_percentage_away_wins
    assert_equal 0.33, @game_collection.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.0, @game_collection.percentage_ties
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013"=>11, "20152016"=>3, "20142015"=>4}), @game_collection.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.28, @game_collection.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({"20122013"=>4.28, "20152016"=>4.28, "20142015"=>4.28}), @game_collection.average_goals_by_season
  end



end
