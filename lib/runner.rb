require_relative './stat_tracker'
require_relative './team_manager'
require_relative './game_manager'
require_relative './game_teams_manager'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

# game_path = 'data/fixture/games_dummy.csv'
# team_path = './data/teams.csv'
# game_teams_path = 'data/fixture/game_teams_dummy.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
