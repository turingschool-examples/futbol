require_relative './test_helper'
require './lib/games_collection'
require 'csv'

class GamesCollectionTest < Minitest::Test

  def setup
    @parent = mock("Collection")
    @parent.stubs(:find_by_id => "FC Dallas")
    @gamescollection = GamesCollection.new('./data/games_dummy.csv', @parent)
  end

  def test_it_exists

    assert_instance_of GamesCollection, @gamescollection
  end

  def test_first_game

    assert_instance_of Game, @gamescollection.games[0]
  end

  def test_create_games

    @gamescollection.create_games('./data/games_dummy.csv')
    assert_equal 26, @gamescollection.games.length
  end

  def test_highest_total_score

    assert_equal 5, @gamescollection.highest_total_score
  end

  def test_lowest_total_score

    assert_equal 1, @gamescollection.lowest_total_score
  end

  def test_percentage_home_wins

    assert_equal 0.54, @gamescollection.percentage_home_wins
  end

  def test_percentage_visitor_wins

    assert_equal 0.38, @gamescollection.percentage_visitor_wins
  end

  def test_percentage_ties

    assert_equal 0.08, @gamescollection.percentage_ties
  end

  def test_all_games

    assert_equal 13, @gamescollection.games.length
  end

  def test_wins_by_hoa
    assert_equal 7, @gamescollection.wins_by_hoa("home")
    assert_equal 5, @gamescollection.wins_by_hoa("away")
    assert_equal 1, @gamescollection.wins_by_hoa("tie")
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

  def test_best_season


    assert_equal "20132014", @gamescollection.best_season("17")
  end

  def test_worst_season

    assert_equal "20132014", @gamescollection.worst_season("16")
  end

  def test_average_win_percentage

    assert_equal 0.5, @gamescollection.average_win_percentage("17")
  end

  def test_goals_scored_by_team
    expected = {"2012030231"=>2, "2012030232"=>1, "2012030233"=>1, "2012030234"=>0}

    assert_equal expected, @gamescollection.goals_scored_by_team("16")
  end

  def test_most_goals_scored

    assert_equal 2, @gamescollection.most_goals_scored("16")
  end

  def test_fewest_goals_scored

    assert_equal 0, @gamescollection.fewest_goals_scored("16")
  end

  def test_team_wins_by_opponent
    expected = {"17"=>{:wins=>1, :total=>4}}
    assert_equal expected, @gamescollection.team_wins_by_opponent("16")
  end

  def test_team_wins_by_season
    expected = {"17"=>{:wins=>1, :total=>4}}
    assert_equal expected, @gamescollection.team_wins_by_opponent("16")
  end

  def test_favorite_opponent

    assert_equal "17", @gamescollection.favorite_opponent("16")
  end

  def test_rival

    assert_equal "3", @gamescollection.rival("6")
  end
end
