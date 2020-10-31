require './test/test_helper'

class GameRepoTest < Minitest::Test
  def setup
    games_path = './data/games.csv'
    @stat_tracker = StatTracker.new(games_path)
  end

  def test_it_return_games_by_season

  end

end