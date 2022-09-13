# runner.rb
require './lib/stat_tracker'
require 'csv'

game_path = CSV.open './data/games.csv', headers: true, header_converters: :symbol
team_path = CSV.open './data/teams.csv', headers: true, header_converters: :symbol
game_teams_path = CSV.open './data/game_teams.csv', headers: true, header_converters: :symbol

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
