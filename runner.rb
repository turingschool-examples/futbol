# require 'csv'

require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
  # CSV.readlines(game_path, headers:true, header_converters: :symbol).map do |row|
  # require 'pry'; binding.pry
  # end
stat_tracker = StatTracker.from_csv(locations)
