require "./test/test_helper"


class GameManagerTest < Minitest::Test
  def setup
    @game_data = './data/games_to_test.csv'

    @game_manager = GameManager.new(@game_data)
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  # def test_highest_scoring_game
  #   assert_equal 0, @game_manager.highest_scoring_game
  # end

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
    expected = {20122013=>10, 20132014=>26, 20162017=>10, 20172018=>12, 20152016=>5}

    assert_equal expected, @game_manager.number_of_season_games
  end

  def test_average_goals_per_game
    expected = {20122013=>3.8, 20132014=>4.27, 20162017=>3.8, 20172018=>4.75, 20152016=>4.2}

    assert_equal expected, @game_manager.average_goals_per_match
  end

  def test_average_goals_by_season
    expected = {20122013=>3.8, 20132014=>4.27, 20162017=>3.8, 20172018=>4.75, 20152016=>4.2}

    assert_equal expected, @game_manager.average_goals_by_season
  end

  def test_games_by_season
    assert_equal @game_manager.games_by_season.keys.first, 20122013
  end
end
