require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

game_path_test = './data/games_test.csv'
team_path_test = './data/teams_test.csv'
game_teams_path_test = './data/game_teams_test.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

locations_test = {
  games: game_path_test,
  teams: team_path_test,
  game_teams: game_teams_path_test
}

stat_tracker_test = StatTracker.from_csv(locations_test)
# stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
