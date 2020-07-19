require "minitest/autorun"
require "minitest/pride"
require "./lib/game_statistics"
require "./lib/game"
require 'csv'
require 'pry'

class GameStatisticsTest < MiniTest::Test

  def setup
    game_path = './data/dummy_file_games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game = Game.new()
    array_dummy = CSV.read(@locations[:games])
    @game.create_stat_hash_keys(array_dummy)
  end

  def test_it_exists
    game_statistics = GameStatistics.new(@game.stat_hash)
    assert_instance_of GameStatistics, game_statistics
  end

  def test_it_has_a_total_score
    game_statistics = GameStatistics.new(@game.stat_hash)
    assert_equal 3, game_statistics.total_goals[2]
  end

  def test_highest_total_score
    game_statistics = GameStatistics.new(@game.stat_hash)
    assert_equal 5, game_statistics.highest_total_score
  end

  def test_lowest_total_score
    game_statistics = GameStatistics.new(@game.stat_hash)

    assert_equal 1, game_statistics.lowest_total_score
  end

  def test_it_can_determine_percentage_of_home_wins
    game_statistics = GameStatistics.new(@game.stat_hash)
    assert_equal 68.42, game_statistics.percentage_home_wins
  end

  def test_count_total_games_by_season
    game_statistics = GameStatistics.new(@game.stat_hash)

    assert_equal ({"20122013" => 19}), game_statistics.count_games_by_season
  end


  def test_average_goals_by_season
    game_statistics = GameStatistics.new(@game.stat_hash)

    assert_equal ({"20122013" => 3.68}), game_statistics.average_goals_by_season
  end

  def test_average_goals_per_game
    game_statistics = GameStatistics.new(@game.stat_hash)

    assert_equal 3.68, game_statistics.average_goals_per_game

  end

  def test_it_can_determine_percentage_of_visitor_wins
    game_statistics = GameStatistics.new(@game.stat_hash)
    assert_equal 26.32, game_statistics.percentage_visitor_wins
  end

  def test_it_can_determine_percentage_ties
    assert_equal 5.26, game_statistics.percentage_ties
  end
end
