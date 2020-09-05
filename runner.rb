require './lib/stat_tracker'

game_path = './data/dummy_game_path.csv'
team_path = './data/dummy_team_path.csv'
game_teams_path = './data/dummy_game_teams_path.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
