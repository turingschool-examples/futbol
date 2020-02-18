require_relative 'test_helper'
require './lib/data_loadable'
require './lib/game'
require './lib/game_stats'

class GameStatsTest < Minitest::Test

  def setup
    @game_stats = GameStats.new("./data/games_truncated.csv", Game)
    @game = @game_stats.games[1]
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_game_objects_are_new_instances_of_game_class
    assert_instance_of Game, @game_stats.games.first
  end

  def test_attributes_for_instance_of_game_withing_game_stats
    assert_equal "2013030411", @game.game_id
    assert_equal "20132014", @game.season
    assert_equal "Postseason", @game.type
    assert_equal "3", @game.away_team_id
    assert_equal "26", @game.home_team_id
    assert_equal 2  , @game.away_goals
    assert_equal 3, @game.home_goals
  end

  def test_returns_highest_total_score
    assert_equal 5, @game_stats.highest_total_score
  end
end
