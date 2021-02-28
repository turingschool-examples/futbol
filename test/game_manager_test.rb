require './test/test_helper'

class GameManagerTest < Minitest::Test
  def setup
    @game_data = GameManager.new('data/fixture/games_dummy.csv')
  end

  def test_it_exists
    assert_instance_of GameManager, @game_data
  end

  def test_highest_total_score
    assert_equal 10, @game_data.highest_total_score
  end
##Edgecase for multiple highest scores - array?

  def test_lowest_total_score_in_game
    assert_equal 1, @game_data.lowest_total_score
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

  def test_percentage_ties
    assert_equal 0.10, @game_data.percentage_ties
  end

  def test_make_game_ids_by_season_hash
    expected = {20122013=>[2012030221, 2012030222, 2012030223, 2012030224,
      2012030225, 2012030311], 20132014=>[2012030312, 2012030313, 2012030314,
      2012030559]}

    assert_equal expected, @game_data.make_game_ids_by_season_hash
  end

  def test_count_of_games_by_season
    expected = {
              20122013 => 6,
              20132014 => 4
                }
    assert_equal expected, @game_data.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.40, @game_data.average_goals_per_game
  end

  def test_average_goals_per_season
    assert_equal 4.17, @game_data.average_goals_in_a_season(20122013)
    assert_equal 4.75, @game_data.average_goals_in_a_season(20132014)
  end

  def test_average_goals_by_season
    expected = {
              20122013 => 4.17,
              20132014 => 4.75
                }
    assert_equal expected, @game_data.average_goals_by_season
  end
end
