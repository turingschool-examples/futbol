require './lib/stat_tracker'
require './lib/team_data'
require './lib/game_data'
require './lib/game_stats_data'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_stats_path = './data/game_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_stats: game_stats_path
}

stat_tracker = StatTracker.from_csv(locations)
