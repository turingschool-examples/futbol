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
    assert_equal 16, @gamescollection.games.length
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

  def test_lowest_total_score
    assert_equal 2, @gamescollection.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 2, @gamescollection.biggest_blowout
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>3, "20142015"=>8, "20152016"=>2, "20162017"=>2, "20132014"=>1}
    assert_equal expected, @gamescollection.count_of_games_by_season
  end

  def test_percentage_ties
    assert_equal 0.06, @gamescollection.percentage_ties
  end

  def test_it_calculates_percentage_of_home_wins
    assert_equal 0.38, @gamescollection.percentage_home_wins
  end

  def test_it_calculates_percentage_of_visitor_wins
    assert_equal 0.56, @gamescollection.percentage_visitor_wins
  end

  def test_average_goals_per_game
    assert_equal 4.06, @gamescollection.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({"20122013"=>4.0, "20142015"=>3.88, "20152016"=>4.0, "20162017"=>4.0, "20132014"=>6.0}), @gamescollection.average_goals_by_season
  end

  def test_best_offence_id
    assert_equal 14, @gamescollection.best_offence_id
  end

  def test_worst_offence_id
    assert_equal 16, @gamescollection.worst_offence_id
  end

  def test_season_game_ids
    assert_equal [2013020246], @gamescollection.reg_season_game_ids("20132014")
    assert_equal [], @gamescollection.post_season_game_ids("20132014")
  end

  def test_winningest_coach_game_ids
    expected = [2014030113, 2014030212,
      2014020930, 2014020614, 2014020772,
      2014020675, 2014021227, 2014020868]
    assert_equal expected, @gamescollection.winningest_coach_game_ids("20142015")
  end

  def test_best_season

    assert_equal "20122013", @gamescollection.best_season("6")
  end

  def test_worst_season
    assert_equal "20122013", @gamescollection.worst_season("6")
  end



end
