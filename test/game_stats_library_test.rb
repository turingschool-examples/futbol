require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_collection'
require './lib/team_collection'
require './lib/statistics_library'
require './lib/game_stats_library'

class GameStatsLibraryTest < MiniTest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    @info = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game_stats = GameStatsLibrary.new(@info)
  end

  def test_it_exists
    assert_instance_of GameStatsLibrary, @game_stats
  end

  def test_it_can_return_highest_total_score
    assert_equal 6, @game_stats.highest_total_score
  end

  def test_it_can_return_lowest_total_score
    assert_equal 3, @game_stats.lowest_total_score
  end

  def test_it_can_return_percentage_home_wins
    assert_equal 0.60, @game_stats.percentage_home_wins
  end

  def test_it_can_return_percentage_visitor_wins
    assert_equal 0.20, @game_stats.percentage_visitor_wins
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.20, @game_stats.percentage_ties
  end

  def test_it_can_return_count_of_games_by_season
    assert_equal ({"20122013"=>3, "20142015"=>1, "20172018"=>1}), @game_stats.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 4.8, @game_stats.average_goals_per_game
  end

  def test_it_can_return_average_goals_by_season
    assert_equal ({"20122013"=>4.67, "20142015"=>6.0, "20172018"=>4.0}), @game_stats.average_goals_by_season
  end
end
