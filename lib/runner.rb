# runner.rb
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

<<<<<<< HEAD
=======

>>>>>>> d47329378e2b4b86fa1a8c973fe2d2de9882d2ef
require 'pry'
binding.pry
