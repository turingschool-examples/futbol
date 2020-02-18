require_relative 'test_helper'
require './lib/data_loadable'
require './lib/game'
require './lib/game_stats'


class GameStatsTest < Minitest::Test

  def setup
    @game_stats = GameStats.new("./data/games_truncated.csv", Game)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_game_objects_are_new_instances_of_game_class
    assert_instance_of Game, @game_stats.games.first
  end
end
