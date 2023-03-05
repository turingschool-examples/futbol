require_relative './spec_helper'

describe Helper do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)

    # @test_games = @stat_tracker.games[0..9]
    # @test_games_larger = @stat_tracker.games[0..100]
    # @test_game_teams = @stat_tracker.game_teams[0..9]
  end
end
