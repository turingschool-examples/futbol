require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = { # all locations of the csv files we need
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = Stat_Tracker.from_csv(locations) # create a new instance of StatTracker and call the from_csv method on it

require 'pry'; binding.pry