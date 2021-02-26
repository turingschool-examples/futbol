require "./test/test_helper"


class GameManagerTest < Minitest::Test
  def setup
    @game_data = './data/games_to_test.csv'

    @game_manager = GameManager.new(@game_data)
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  def test_highest_scoring_game
    assert_equal 0, @game_manager.highest_scoring_game
  end

  def test_highest_total_score

  end

  def test_lowest_total_score

  end

  def test_percentage_home_wins

  end

  def test_percentage_visitor_wins

  end

  def test_percentage_ties

  end

  def test_number_of_season_games
    expected = {"20122013" => 20, "20122014" => 25}

    assert_equal expected, @game_manager.number_of_season_games
  end

  def test_average_goals_per_game
    expected = 4.5

    assert_equal expected, @game_manager.average_goals_per_match
  end

  def test_average_goals_by_season

  end
end
