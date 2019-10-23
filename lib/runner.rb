require 'csv'
require './lib/stat_tracker'
require './lib/game_teams'
require './lib/game_teams_collection'


game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

game_teams_array = stat_tracker.game_teams
game_teams_array.game_teams_instances.first

team_array = stat_tracker.team
team_array.team_instances.first

game_array = stat_tracker.game
game_array.game_instances.first

