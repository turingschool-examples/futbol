require './test/test_helper'
require './lib/game'
require './lib/game_collection'


class GameCollectionTest < Minitest::Test

  def setup
    @game_collection = GameCollection.new('./data/games_fixture.csv')
    @game = @game_collection.games_array.first
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_collection.games_array
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Game, @game
    assert_equal "2012030221", @game.game_id
  end

  def test_it_can_find_sum_of_game_scores
    expected = [5, 5, 3, 5, 4, 3, 5, 3, 1, 3, 5, 5, 6, 4, 3, 2, 6, 3, 4, 4, 4, 5, 5, 3, 5, 5, 5]
    assert_equal expected, @game_collection.sum_of_game_goals_list
  end

  def test_it_has_highest_total_score
    assert_equal 6, @game_collection.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 1, @game_collection.lowest_total_score
  end

  def test_it_can_find_all_home_wins
    expected = ["2012030221", "2012030222", "2012030225", "2012030313", "2012030314", "2013020674", "2012020225", "2012020577", "2017020109", "2017020883", "2014030324", "2014030325", "2014030326"]

    assert_equal expected, @game_collection.home_wins
  end

  def test_it_can_find_all_away_wins
    expected = ["2012030223", "2012030224", "2012030311", "2012030312", "2013020177", "2012020122", "2016020479", "2014030322", "2014030323"]

    assert_equal expected, @game_collection.away_wins
  end

  def test_it_can_find_all_away_wins
    expected = ["2013021085", "2017020626", "2016020592", "2016021045", "2015020402"]

    assert_equal expected, @game_collection.ties
  end

  def test_it_has_percentage_home_wins
    assert_equal 0.48, @game_collection.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 0.33, @game_collection.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 0.19, @game_collection.percentage_ties
  end

  def test_it_can_categorize_games_by_season
    assert_equal 12, @game_collection.games_by_season["20122013"].count
  end

  def test_it_finds_count_of_games_by_season
    assert_equal ({"20122013"=>12, "20132014"=>3, "20172018"=>3, "20162017"=>3, "20152016"=>1, "20142015"=>5}), @game_collection.count_of_games_by_season
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 4.11, @game_collection.average_goals_per_game
  end

  def test_has_average_goals_by_season
    expected = {"20122013"=>4.0, "20132014"=>4.0, "20172018"=>3.67, "20162017"=>4.33, "20152016"=>4.0, "20142015"=>4.6}
    assert_equal expected, @game_collection.average_goals_by_season
  end
end
