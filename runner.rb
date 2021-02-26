require './lib/stat_tracker'
require './lib/teams_manager'
game_path = './dummy_data/games_dummy.csv'
team_path = './dummy_data/teams_dummy.csv'
game_teams_path = './dummy_data/game_teams_dummy.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


stat_tracker = StatTracker.from_csv(locations)
