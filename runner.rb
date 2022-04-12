<<<<<<< HEAD
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'
=======
# runner.rb
require './lib/stat_tracker'

game_path = './data/games_sample.csv'
team_path = './data/teams.csv'
game_teams_path = './data/games_teams_sample.csv'
>>>>>>> 2346adb243de0c1c7f1a7560b28a1cfdd3bdf05e

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
