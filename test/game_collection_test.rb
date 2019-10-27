require './test/test_helper'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new("./test/data/games_sample.csv")
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_has_total_games
    @game_collection.create_games('./test/data/games_sample.csv')
    assert_equal 20, @game_collection.total_games.length
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 10, @game_collection.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 0, @game_collection.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 6, @game_collection.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.45, @game_collection.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.40, @game_collection.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.15, @game_collection.percentage_ties
  end

  def test_it_can_calculate_count_of_games_by_season
    count_games_by_season_list = {
      "20172018" => 10,
      "20152016" => 10
    }
    assert_equal count_games_by_season_list, @game_collection.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 4.60, @game_collection.average_goals_per_game
  end

  def test_it_can_calculate_average_goals_by_season
    count_goals_by_season_list = {
      "20172018" => 4.10,
      "20152016" => 5.10
    }
    assert_equal count_goals_by_season_list, @game_collection.average_goals_by_season
  end

  def test_it_can_group_by_away_team_id_and_goals
    away_group = [[3, 2], [3, 2], [6, 2], [9, 2], [24, 2], [16, 2], [6, 3], [6, 2]]
    assert_equal away_group, @game_collection.group_by_away_team_id_and_goals
  end

  def test_it_can_group_by_home_team_id_and_goals
    home_group = [[6, 3], [6, 3], [3, 1], [8, 2], [17, 0], [52, 1], [30, 2], [21, 2]]
    assert_equal home_group, @game_collection.group_by_home_team_id_and_goals
  end

  def test_sum_of_away_games
    away_game_sum = {3=>4, 6=>7, 9=>2, 24=>2, 16=>2}
    assert_equal away_game_sum, @game_collection.sum_of_away_games
  end

  def test_sum_of_home_games
    home_game_sum = {6=>6, 3=>1, 8=>2, 17=>0, 52=>1, 30=>2, 21=>2}
    assert_equal home_game_sum, @game_collection.sum_of_home_games
  end

  def test_count_of_away_games
    away_games_count = {3=>2, 6=>3, 9=>1, 24=>1, 16=>1}
    assert_equal away_games_count, @game_collection.count_of_away_games
  end

  def test_count_of_home_games
    home_game_count = {6=>2, 3=>1, 8=>1, 17=>1, 52=>1, 30=>1, 21=>1}
    assert_equal home_game_count, @game_collection.count_of_home_games
  end

  def test_highest_average_away_goals
    assert_equal 3, @game_collection.highest_average_away_goals
  end

  def test_highest_average_home_goals
    assert_equal 6, @game_collection.highest_average_home_goals
  end

  def test_lowest_average_away_goals
    assert_equal 3, @game_collection.lowest_average_away_goals
    #returns 3 because multiple teams have an average of 2 goals
  end

  def test_lowest_average_home_goals
    assert_equal 0, @game_collection.lowest_average_home_goals
  end
end
