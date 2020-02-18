require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/game_teams_stats.rb'

class GameTeamsStatsTest < Minitest::Test

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
    @game_teams_stats = GameTeamsStats.new(@stat_tracker.game_teams_path)
  end

  def test_it_can_exist
    assert_instance_of GameTeamsStats, @game_teams_stats
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 66.67, @game_teams_stats.percentage_home_wins
  end

end
