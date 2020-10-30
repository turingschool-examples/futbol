require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/games_repo'
require 'mocha/minitest'
require './lib/game'

class GamesRepoTest < Minitest::Test
  def setup
    game_path = './data/games.csv'

    locations = {
      games: game_path
    }
    @parent = mock()

    @games_repo = GamesRepo.new(locations[:game_path], @parent)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Array, @games_repo.games
    assert mock(), @parent
  end

  def test_create_game
    assert_instance_of Game, @games_repo.games[0]
  end

  def test_it_can_select_highest_total_goals
    assert_equal 11, @games_repo.highest_total_goals
  end

  def test_it_can_select_lowest_total_goals
    assert_equal 0, @games_repo.lowest_total_goals
  end

  def test_it_can_count_games_in_season
    assert_equal 806, @games_repo.count_of_games_in_season("20122013")
  end

  def test_it_can_return_hash_games_by_season
    expected = {"20122013"=>806,
                "20162017"=>1317,
                "20142015"=>1319,
                "20152016"=>1321,
                "20132014"=>1323,
                "20172018"=>1355}
    assert_equal expected ,@games_repo.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game
    assert_equal 4.22, @games_repo.average_goals_per_game
  end

  def test_it_can_average_goals_by_season
    expected = {"20122013"=>4.12,
                "20162017"=>4.23,
                "20142015"=>4.14,
                "20152016"=>4.16,
                "20132014"=>4.19,
                "20172018"=>4.44}
    assert_equal expected, @games_repo.average_goals_by_season
  end
end
