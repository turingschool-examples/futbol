require './lib/stat_tracker'
require 'CSV'

game_path = './data/games_test.csv'
team_path = './data/teams_test.csv'
game_teams_path = './data/game_teams_test.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
