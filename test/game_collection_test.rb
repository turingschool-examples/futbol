require_relative 'test_helper'
require_relative '../lib/game_collection'

class GamecollectionTest < Minitest::Test

  def setup
    game_path = "./test/dummy_game_data.csv"
    @game_collection = GameCollection.new(game_path)
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 7, @game_collection.highest_total_score
  end

  def test_it_can_calculate_lowest_goal_total
    assert_equal 2, @game_collection.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 3, @game_collection.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 33.33, @game_collection.percentage_home_wins
    #3 wins in test sample
  end

  def test_percentage_visitor_wins
    assert_equal 41.67, @game_collection.percentage_visitor_wins
    #5 wins in test sample
  end

  def test_percentage_ties
    assert_equal 25.00, @game_collection.percentage_ties
  end

  def test_it_can_give_number_of_games_in_season
    expected = {
    "20122013" => 5,
    "20132014" => 1,
    "20142015" => 1,
    "20152016" => 2,
    "20162017" => 2,
    "20172018" => 1
    }
    assert_equal expected, @game_collection.count_of_games_by_season
  end

  def test_it_can_count_goals_per_season
    expected = {
      "20122013" => 18,
      "20132014" => 5,
      "20142015" => 2,
      "20152016" => 12,
      "20162017" => 6,
      "20172018" => 4
      }
    assert_equal expected, @game_collection.goal_count_per_season
  end

  def test_it_can_get_average_goals_per_season
    expected = {
      "20122013" => 3.60,
      "20132014" => 5.00,
      "20142015" => 2.00,
      "20152016" => 6.00,
      "20162017" => 3.00,
      "20172018" => 4.00
    }
    assert_equal expected, @game_collection.average_goals_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 3.92, @game_collection.average_goals_per_game
  end

  def test_it_can_sort_number_of_games_by_away_team_id
    expected = {"6" => 3,
                "16" => 2,
                "9" => 1,
                "30" => 1,
                "25" => 2,
                "10" => 1,
                "19" => 1,
                "15" => 1
              }
    assert_equal expected, @game_collection.number_away_games_by_away_team_id
  end

  def test_it_can_sort_total_away_goals_by_away_team_id
    expected = {"6" => 6,
                "16" => 2,
                "9" => 2,
                "30" => 3,
                "25" =>6,
                "10" => 1,
                "19" => 2,
                "15" => 2
              }
    assert_equal expected, @game_collection.total_away_goals_by_away_team_id
  end

  def test_it_can_find_average_away_goals_by_away_team_id
    expected = {"6" => 2,
                "16" => 1,
                "9" => 2,
                "30" => 3,
                "25" =>3,
                "10" => 1,
                "19" => 2,
                "15" => 2
                }
    assert_equal expected, @game_collection.average_away_goals_by_away_team_id
  end

  def test_it_can_return_away_team_id_for_highest_average_goals
    assert_equal "30", @game_collection.away_team_id_for_highest_average_goals
  end
end
