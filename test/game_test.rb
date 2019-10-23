require 'minitest'
require 'minitest/autorun'
require_relative '../lib/stat_tracker'

class GameTest < MiniTest::Test
  def setup
    @stat_tracker = StatTracker.new([@game1, @game2, @game3])
    @game1 = Game.new('1', '20122013', 'postseason', '12/08/2012', '3', '18', 1, 3, 'Allianz Field', '/api/v1/venues/null' )
    @game2 = Game.new('2', '20122013', 'postseason', '01/13/2013', '14', '4', 2, 3, 'Seatgeek Stadium', '/api/v1/venues/null')
    @game3 = Game.new('3', '20122013', 'postseason', '11/12/2012', '3', '23', 3, 6, 'Saputo Stadium', '/api/v1/venues/null')
    @game4 = Game.new('4', '20122013', 'postseason', '10/31/2012', '5', '12', 2, 1, 'Mile High Stadium', '/api/v1/venues/null')
    @game5 = Game.new('5', '20122013', 'postseason', '11/11/2012', '1', '13', 0, 0, 'Fenway Park', '/api/v1/venues/null')
  end

  def test_existence
    assert_instance_of Game, @game1
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_highest_total_score
    assert_equal 9, @stat_tracker.games.highest_total_score

  end

  def test_lowest_total_score
    assert_equal 0, @stat_tracker.games.lowest_total_score
  end

  def test_largest_blowout
    assert_equal @game3, @stat_tracker.games.biggest_blowout
  end

  def test_percent_home_wins
    assert_equal 60, @stat_tracker.games.percentage_home_wins
  end

  def test_percent_visitor_wins
    assert_equal 20, @stat_tracker.games.percentage_visitor_wins
  end

  def test_percent_ties
    assert_equal 20, @stat_tracker.games.percentage_ties
  end

  def test_games_by_season
    assert_equal {'20122013' => 5}, @stat_tracker.games.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.20, @stat_tracker.games.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal {'20122013' => 4.20}, @stat_tracker.games.average_goals_by_season
  end

end
