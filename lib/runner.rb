require_relative './stat_tracker'
require_relative './team_data'
require_relative './game_data'
require_relative './game_stats_data'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_stats_path = './data/game_stats.csv'

# game_path = 'data/fixture/games_dummy.csv'
# team_path = './data/teams.csv'
# game_stats_path = 'data/fixture/game_stats_dummy.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_stats: game_stats_path
}

stat_tracker = StatTracker.from_csv(locations)
