require 'csv'
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
 game_array = stat_tracker.game
require "pry"; binding.pry
game_array.game_instances.first
