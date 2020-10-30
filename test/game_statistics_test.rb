require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_statistics'
require './lib/object_data'
require './lib/stat_tracker'
require './test/test_helper'


class GameStatisticsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @object_data ||= ObjectData.new(@stat_tracker)
    @game_statistics = GameStatistics.new
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_highest_total_score
    assert_equal 11, @game_statistics.highest_total_score(@object_data.games)
  end

  def test_lowest_total_score
    assert_equal 0, @game_statistics.lowest_total_score(@object_data.games)
  end

  def test_total_goals_by_game
    assert_equal 6, @game_statistics.total_goals_by_game(@object_data.games)["2017030235"]
    assert_equal 3, @game_statistics.total_goals_by_game(@object_data.games)["2015030235"]
    assert_equal 7441, @game_statistics.total_goals_by_game(@object_data.games).size
  end

  def test_total_games
    assert_equal 7441, @game_statistics.total_games(@object_data.games)
  end

  def test_total_home_wins
    assert_equal 3237, @game_statistics.total_home_wins(@object_data.games)
  end

  def test_percentage_home_wins
    assert_equal 0.44, @game_statistics.percentage_home_wins(@object_data.games)
  end

  def test_total_away_wins
    assert_equal 2687, @game_statistics.total_away_wins(@object_data.games)
  end

  def test_percentage_visitor_wins
    assert_equal 0.36, @game_statistics.percentage_visitor_wins(@object_data.games)
  end

  def test_total_ties
    assert_equal 1517, @game_statistics.total_ties(@object_data.games)
  end

  def test_percentage_ties
    assert_equal 0.20, @game_statistics.percentage_ties(@object_data.games)
  end

  def test_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @game_statistics.count_of_games_by_season(@object_data.games)
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, @game_statistics.average_goals_by_season(@object_data.games)
  end
end
