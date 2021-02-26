require './test/test_helper'

class GameDataTest < Minitest::Test
  def setup
    @game_path = './test/games_dummy.csv'

    locations = {
      games: @game_path
    }

    @stat_tracker = mock

    @game_data = GameData.new(locations[:games], @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameData, @game_data
    assert mock, @stat_tracker
  end

  def test_highest_total_score_in_game
    assert_equal 10, @game_data.highest_total_score_in_game
  end
##Edgecase for multiple highest scores - array?

  def test_lowest_total_score_in_game
    assert_equal 1, @game_data.lowest_total_score_in_game
  end
  ##Edgecase for multiple highest scores - array?

  def test_home_wins_array
    assert_equal 5, @game_data.home_wins_array.count
  end

  def test_percentage_home_wins
    assert_equal 0.50, @game_data.percentage_home_wins
  end
  #BigDecimal? to return two decimal values - zeros
  def test_visitor_wins_array
    assert_equal 4, @game_data.visitor_wins_array.count
  end

  def test_percentage_visitor_wins
    assert_equal 0.40, @game_data.percentage_visitor_wins
  end

  def test_game_tie_array
    assert_equal 1, @game_data.game_tie_array.count
  end
end
