require_relative 'test_helper'
require './lib/data_module'
require './lib/game'
require './lib/game_stats'


class GameStatsTest < Minitest::Test

  def setup
    @game_stats = GameStats.new("./data/games_truncated.csv")
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end
end
