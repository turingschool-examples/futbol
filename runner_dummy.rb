# runner.rb
require './lib/stat_tracker'

game_path = './data/s_game.csv'
team_path = './data/teams.csv'
game_teams_path = './data/s_team_game.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry