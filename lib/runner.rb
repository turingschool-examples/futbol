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
 team_array = stat_tracker.team
require "pry"; binding.pry
team_array.team_instances.first
game_array.game_instances.first
