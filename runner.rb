# runner.rb
require './lib/stat_tracker'
require './lib/game_team_factory'
require './lib/game_factory'
require './lib/teams_factory'

game_path = './data/games_test.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_team_test.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.new
stat_tracker.from_csv(locations)

require 'pry'
binding.pry
