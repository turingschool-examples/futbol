require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/games_repo'

class GamesRepoTest < Minitest::Test
  def setup
    game_path = './data/games.csv'

    locations = {
      games: game_path
    }

    @games_repo = GamesRepo.new(locations[:game_path], self)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Array, @games_repo.games
  end
end