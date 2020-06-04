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
require './lib/team_statistics_library'

class TeamStatisticsTest < MiniTest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    @info = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

    @team_stats = TeamStatisticsLibrary.new(@info)
  end

  def test_it_returns_team

    assert @team_stats.team_info("1")
  end

  def test_it_returns_total_games
    assert_equal 5, @team_stats.total_games("6")
  end

  def test_it_counts_wins
    assert_equal 3, @team_stats.count_wins("6", 4)
  end

  def test_it_returns_total_wins_per_season
    assert_equal ({"20122013" => 3}), @team_stats.total_team_wins_per_season("6")
  end

  def test_it_returns_win_percentage_per_season
    assert_equal ({"20122013"=>1.0, "20142015"=>0.0, "20172018"=>0.0}), @team_stats.percentage_wins_per_season("6")
  end

  def test_it_can_return_best_season
    assert_equal "20122013", @team_stats.best_season("6")
  end

  def test_it_can_return_worst_season
    assert_equal "20172018", @team_stats.worst_season("6")
  end

  def test_it_returns_average_win_percentage
    assert_equal 0.6, @team_stats.average_win_percentage("6")
  end

  def test_it_returns_most_goals_scored
    assert_equal 3, @team_stats.most_goals_scored("6")
  end

  def test_it_returns_fewest_goals_scored
    assert_equal 1, @team_stats.fewest_goals_scored("6")
  end

  def test_it_returns_favorite_opponent
    assert_equal "Houston Dynamo", @team_stats.favorite_opponent("6")
  end

  def test_it_can_return_rival
    assert_equal "North Carolina Courage", @team_stats.rival("6")
  end
end
