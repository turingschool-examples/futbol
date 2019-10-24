require './test/test_helper'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test

  def setup
    @game_collection = GameCollection.new("./data/games_sample.csv")
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_total_games
    @game_collection.create_games('./data/games_sample.csv')
    assert_equal 7, @game_collection.total_games.length
  end

  def test_it_can_calculate_highest_total_score
    # look at our dumb file and figure out what that is
    assert_equal 5, @game_collection.highest_total_score
  end

  def test_it_can_calculate_percentage_ties
    assert_equal (2/7.0).round(2), @game_collection.percentage_ties
  end

  def test_it_can_calculate_count_of_games_by_season
    count_games_by_season_list = {
      20122013 => 4,
      20142015 => 3
    }
    assert_equal count_games_by_season_list, @game_collection.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    # 15 away goals, 14 home goals, (29 total goals / 7 games)
    assert_equal (29/7.0).round(2), @game_collection.average_goals_per_game
  end

  def test_it_can_calculate_average_goals_by_season
    # 2012/2013 17 goals / 4 games
    # 2014/2015 12 goals / 3 games
    count_goals_by_season_list = {
      20122013 => (17/4.0).round(2),
      20142015 => (12/3.0).round(2)
    }
    assert_equal count_goals_by_season_list, @game_collection.average_goals_by_season
  end
end
