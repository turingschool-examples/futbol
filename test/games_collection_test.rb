require_relative './test_helper'
require './lib/games_collection'
require 'csv'

class GamesCollectionTest < Minitest::Test

  def setup
    @gamescollection = GamesCollection.new('./data/games_dummy.csv', self)
  end

  def test_it_exists_and_has_attributes

    assert_instance_of GamesCollection, @gamescollection
    assert_equal ["20122013", "20132014"], @gamescollection.season_ids
    assert_equal 2, @gamescollection.season_ids.count
  end

  def test_first_game

    assert_instance_of Game, @gamescollection.games[0]
  end

  def test_all_games

    assert_equal 13, @gamescollection.games.length
  end

  def test_home_wins
    assert_equal 7, @gamescollection.home_wins
  end

  def test_visitor_wins
    assert_equal 5, @gamescollection.visitor_wins
  end

  def test_ties
    assert_equal 1, @gamescollection.ties
  end

  def test_count_of_games_by_season

    expected = {"20122013"=> 12, "20132014"=> 1}
    assert_equal expected, @gamescollection.count_of_games_by_season
  end

  def test_average_goals_per_game

    assert_equal 3.38, @gamescollection.average_goals_per_game
  end

  def test_average_goals_by_season

    expected = {"20122013"=> 3.50, "20132014"=> 2.00}
    assert_equal expected, @gamescollection.average_goals_by_season
  end
end
