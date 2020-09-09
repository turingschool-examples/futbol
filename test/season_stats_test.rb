require_relative 'test_helper'
require "./lib/game_statistics"
require './lib/stat_tracker'
require './lib/season_stats'

class SeasonStatisticsTest < Minitest::Test
  def setup
    # game_teams: head_coach, result, team_id, shots, goals, tackles
    # games: season, team_id
    # teams: teamName, team_id
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @raw_game_stats = @stat_tracker.game_stats
    @raw_game_teams_stats = @stat_tracker.game_teams_stats
    @raw_teams_stats = @stat_tracker.teams_stats
    @season_statistics = SeasonStatistics.new(@raw_game_stats, @raw_game_teams_stats, @raw_teams_stats)
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end
end
