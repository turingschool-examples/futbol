require './lib/game'
require './lib/stat_tracker'

game_path = './spec/fixtures/games.csv'
team_path = './spec/fixtures/teams.csv'
game_teams_path = './spec/fixtures/game_teams.csv'

location_paths = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(location_paths)