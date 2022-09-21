require './lib/stat_tracker'
require "./lib/team"
require "./lib/game"
require "./lib/team_game"
require "./lib/team_statistics"

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
# require "pry"; binding.pry
p stat_tracker.favorite_opponent('18')
