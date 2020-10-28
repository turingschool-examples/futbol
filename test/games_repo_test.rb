require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/games_repo'
require 'mocha/minitest'

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
  end
end