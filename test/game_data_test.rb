require './test/test_helper'

class GameDataTest < Minitest::Test
  def setup
    def self.from_csv(locations)
      StatTracker.new(locations)
    end

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

  def test_percentage_ties
    assert_equal 0.10, @game_data.percentage_ties
  end

  def test_make_game_ids_by_season_hash
    expected = {
                20122013 =>["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311"],
                20132014 =>["2012030312", "2012030313", "2012030314", "2012030559"]
              }

    assert_equal expected, @game_data.make_game_ids_by_season_hash
  end

  def test_count_of_games_by_season
    expected = {
              20122013 => 6,
              20132014 => 4
                }
    assert_equal expected, @game_data.count_of_games_by_season
  end
end
