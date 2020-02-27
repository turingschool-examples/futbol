require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/game_collection'
require 'csv'

class GameCollectionTest < Minitest::Test
  def setup
    @game_file_path = './fixture_files/games_fixture.csv'
    @game_data = CSV.read('./fixture_files/games_fixture.csv',
                 headers: true,
                 header_converters: :symbol)
    @game_collection = GameCollection.new(@game_data)

  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
    assert_instance_of Game, @game_collection.games.first
    assert_equal 9, @game_collection.games.length
  end

  def test_it_can_return_the_highest_total_score
    assert_equal 5, @game_collection.highest_total_score
    #harness pass
  end

  def test_it_can_return_lowest_score
    assert_equal 3, @game_collection.lowest_total_score
    #harness pass
  end

  def test_it_can_load_total_scores_by_team
    assert_equal [2, 2, 2], @game_collection.total_scores_by_team('3')
  end

  def test_it_can_return_the_biggest_blowout
    assert_equal 3, @game_collection.biggest_blowout
    #narness pass
  end

  def test_can_return_percentage_of_home_wins
    assert_equal 0.56, @game_collection.percentage_home_wins
    #harness pass
  end

  def test_can_return_percentage_of_visitor_wins
    assert_equal 0.11, @game_collection.percentage_visitor_wins
    #harness pass
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.33, @game_collection.percentage_ties
    #jarness pass
  end

  def test_it_can_return_a_count_of_games_per_season
    expected = {
      "20122013" => 5,
      "20152016" => 4
    }
    assert_equal expected, @game_collection.count_of_games_by_season
    #harness pass
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 3.78, @game_collection.average_goals_per_game
    #harness pass
  end

  def test_it_can_return_average_goals_by_season
    expected = {"20122013"=>3.6, "20152016"=>4.0}

    assert_equal expected, @game_collection.average_goals_by_season
    #harness pass
  end

  def test_it_can_count_total_games_by_team
    expected = {3=>3, 6=>2, 9=>1, 8=>1, 5=>4, 20=>1, 19=>1,
      7=>1, 52=>1, 10=>1, 26=>1, 22=>1}

    assert_equal expected, @game_collection.total_games_by_team
  end

  def test_it_can_count_goals_allowed_by_team
    expected = {3=>8, 6=>2, 9=>2, 8=>2, 5=>9, 20=>2, 19=>1, 7=>2,
      52=>1, 10=>2, 26=>1, 22=>2}

    assert_equal expected, @game_collection.all_goals_allowed_by_team
  end
end
