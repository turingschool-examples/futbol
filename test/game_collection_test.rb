require './test/test_helper'
require './lib/game_collection'

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

  def test_it_can_calculate_average_goals_per_game
    expected = 4.31
    assert_equal  expected, @game_collection.average_goals_per_game
  end

  def test_it_can_store_games_by_season
    assert_equal 4, @game_collection.game_lists_by_season.length
  end

  def test_games_by_season
    expected = {"20162017" => 4, "20142015" => 6, "20152016" => 10, "20132014" => 6}
    assert_equal expected, @game_collection.games_by_season
  end

  def test_it_can_calculate_average_goals_by_season
    avg_goals_by_season = @game_collection.average_goals_by_season
    assert_equal 4.33, avg_goals_by_season["20132014"]
    assert_equal 3.5, avg_goals_by_season["20142015"]
    assert_equal 4.6, avg_goals_by_season["20152016"]
    assert_equal 4.75, avg_goals_by_season["20162017"]
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
