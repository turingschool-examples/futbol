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

  def test_it_has_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_has_percentage_home_wins
    assert_equal 55.56, @stat_tracker.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 38.89, @stat_tracker.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 5.56, @stat_tracker.percentage_ties
  end

  def test_it_finds_count_of_games_by_season
    @stat_tracker.expects(:count_of_games_by_season).returns({"20122013"=>3, "20142015"=>4})
    assert_equal ({"20122013"=>3, "20142015"=>4}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 1.96, @stat_tracker.average_goals_per_game
  end

  def test_has_average_goals_by_season
    @stat_tracker.expects(:average_goals_by_season).returns({"20122013"=>3, "20142015"=>4})
    assert_equal ({"20122013"=>3, "20142015"=>4}), @stat_tracker.average_goals_by_season
  end
end
