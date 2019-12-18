require './test/test_helper'
require './lib/game_collection'
require './lib/game'
require './lib/game_teams'

class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    @game = @game_collection.games.first
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_collection.games
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Game, @game
    assert_equal "20162017", @game.season
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.38, @game_collection.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.58, @game_collection.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.04, @game_collection.percentage_ties
  end

  def test_it_can_get_the_sum_of_highest_winning_and_losing_team_score
    assert_equal 7, @game_collection.highest_total_score
  end

  def test_it_can_get_the_sum_of_lowest_winning_and_losing_team_score
    assert_equal 2, @game_collection.lowest_total_score
  end
  
  def test_it_can_get_biggest_blowout
    assert_equal 3, @game_collection.biggest_blowout
  end
end
