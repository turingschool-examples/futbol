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

  def test_average_goals_per_game
    assert_equal 3.93, @gamescollection.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({20122013=>4.0, 20142015=>3.88, 20152016=>4.0, 20162017=>4.0}), @gamescollection.average_goals_by_season
  end
end
