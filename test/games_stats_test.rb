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

end
