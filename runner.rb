<<<<<<< HEAD
# runner.rb
require './lib/stat_tracker'
=======
require './lib/stat_tracker'
require 'pry'
>>>>>>> da1d55672da52b8e10cbad78824bef25ce722905

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
<<<<<<< HEAD
  game_teams: game_teams_path }

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry
=======
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
binding.pry
>>>>>>> da1d55672da52b8e10cbad78824bef25ce722905
