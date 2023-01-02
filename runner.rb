require './lib/stat_tracker'
require 'csv'
require './lib/game'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
#15=19 should go to stattracker

games = []
CSV.foreach(locations[:games], headers: true) do |info|
  games << Game.new(info)
end
require 'pry'; binding.pry
stat_tracker = StatTracker.from_csv(locations)
