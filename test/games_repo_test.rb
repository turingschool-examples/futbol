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
end