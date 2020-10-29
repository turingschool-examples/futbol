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
    expected = {}
    assert_equal expected ,@games_repo.count_of_games_by_season
  end
end
