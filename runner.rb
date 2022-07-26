# runner.rb
require './lib/stat_tracker'

game_path = CSV.open './data/games.csv'
team_path = CSV.open './data/teams.csv'
game_teams_path = CSV.open './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

p stat_tracker = StatTracker.from_csv(locations)
stat_tracker.teams
require 'pry' ; binding.pry