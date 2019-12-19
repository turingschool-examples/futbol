require_relative '../test_helper'
require "minitest/autorun"
require 'minitest/pride'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    csv_file_path = './test/fixtures/games.csv'
    @game_collection = GameCollection.new(csv_file_path)
    game_info = {:game_id => "2012030221",
                 :season => "20122013",
                 :type => "Postseason",
                 :date_time => "5/16/13",
                 :away_team_id => "3",
                 :home_team_id => "6",
                 :away_goals => "2",
                 :home_goals => "3",
                 :venue => "Toyota Stadium"}
    @first_game = @game_collection.games.first
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_create_games
    assert_instance_of Array, @game_collection.games
    @game_collection.games.each do |game|
      assert_instance_of Game, game
    end
  end

  def test_it_can_return_percentage_home_wins
    assert_equal 53.85, @game_collection.percentage_home_wins
  end

  def test_it_can_return_percentage_visitor_wins
    assert_equal 42.31, @game_collection.percentage_visitor_wins
  end

  def test_it_can_return_percentage_tie_wins
    assert_equal 3.85, @game_collection.percentage_ties
  end

  def test_it_can_return_average_season_game
    result = {"20122013" => 4.25, "20132014" => 5.00, "20142015" => 4.67, "20152016" => 4.56, "20162017" => 3.00}
    assert_equal result, @game_collection.average_goals_by_season
  end

  def test_it_can_find_highest_total_score
    assert_equal 7, @game_collection.highest_total_score
  end

  def test_it_can_find_lowest_total_score
    assert_equal 2, @game_collection.lowest_total_score
  end

  def test_it_can_find_biggest_blowout
    assert_equal 3, @game_collection.biggest_blowout
  end

  def test_games_per_season_method
    expected = {"20122013"=>12, "20152016"=>9, "20132014"=>1, "20142015"=>3, "20162017"=>1}
    assert_equal expected, @game_collection.games_per_season
  end

  def test_average_goals_per_game_method
    assert_equal 4.38, @game_collection.average_goals_per_game
  end

end
