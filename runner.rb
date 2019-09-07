require './lib/stat_tracker'


game_path = './data/dummy_data/games.csv'
team_path = './data/dummy_data/teams.csv'
game_team_path = './data/dummy_data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_team_path
}

stat_tracker = StatTracker.from_csv(locations)
require 'pry'; binding.pry
