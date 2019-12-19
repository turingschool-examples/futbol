require_relative 'testhelper'
require_relative '../lib/games_collection'

class GamesCollectionTest < Minitest::Test

  def setup
    @gamescollection = GamesCollection.new("./test/fixtures/games_trunc.csv")
    @game = @gamescollection.games.first
  end

  def test_it_exists
    assert_instance_of GamesCollection, @gamescollection
  end

  def test_attributes
    assert_equal Array, @gamescollection.games.class
    assert_equal 15, @gamescollection.games.length
  end

  def test_it_can_create_games_from_csv
    assert_instance_of Game, @game
    assert_equal 2012030224, @game.game_id
    assert_equal 3, @game.away_goals
    assert_equal "Postseason", @game.type
  end

  def test_highest_total_score
    assert_equal 6, @gamescollection.highest_total_score
  end

  def test_lowest_totalP_score
    assert_equal 2, @gamescollection.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 2, @gamescollection.biggest_blowout
  end

  def test_it_calculates_percentage_of_home_wins
    assert_equal 0.40, @gamescollection.percentage_home_wins
  end

  def test_it_calculates_percentage_of_visitor_wins
    assert_equal 0.60, @gamescollection.percentage_visitor_wins
  end
end
