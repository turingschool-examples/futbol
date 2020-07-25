require_relative './lib/stat_tracker'
require_relative './lib/game'
require_relative './lib/team'
require_relative './lib/game_teams'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
