require 'csv'
require_relative 'stat_tracker'
require_relative 'game_teams'
require_relative 'game_teams_collection'


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

<<<<<<< HEAD
game_array = stat_tracker.game.all_games
require "pry"; binding.pry
date_1 = game_array.game_instances.sort_by {}
p game_array.game_instances
=======
game_array = stat_tracker.game
game_array.game_instances.first
>>>>>>> 1a8e4011dad76bbfa36ba4fff16a3f37c26450aa
