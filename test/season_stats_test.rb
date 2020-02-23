require_relative 'test_helper'
require './lib/season_stats'
require './lib/stat_tracker'

class SeasonStatsTest < Minitest::Test
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
    @season_stats = SeasonStats.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
  end
end
