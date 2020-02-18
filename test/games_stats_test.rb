require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/games_stats'

class GamesStatsTest < Minitest::Test

  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
    @games_stats = GamesStats.new(@stat_tracker.games_path)
  end

  def test_it_can_exist
    assert_instance_of GamesStats, @games_stats
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 14.29, @games_stats.percentage_ties
  end

  def test_it_can_count_games_by_season
    games_by_season = {
      "20152016" => 3,
      "20132014" => 2,
      "20142015" => 1,
      "20162017" => 1
    }

    assert_equal games_by_season, @games_stats.count_of_games_by_season
  end

  def test_it_can_calculate_percentage_vistor
    assert_equal 28.57, @games_stats.percentage_visitor_wins
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 4.71, @games_stats.average_goals_per_game
  end

  def test_it_can_calculate_average_goals_per_season
    goals_by_season = { '20152016' => 5.33, '20132014' => 5, '20142015' => 3,
                        '20162017' => 4}
    assert_equal goals_by_season, @games_stats.verage_goals_per_season
  end
end
