# runner.rb
require './lib/stat_tracker'
require './lib/game_team'
require './lib/team'
require './lib/game'
require 'csv'

game_path = './data/games_sample.csv'
team_path = './data/teams.csv'
game_teams_path = './data/games_teams_sample.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

hash = {bacon: "protein", apple: "fruit"}
require 'pry'; binding.pry

new_hash = hash.map do |k,v|
  require 'pry'; binding.pry
  [k, v.to_sym]
end.to_h
