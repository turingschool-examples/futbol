require 'CSV'
require 'pry'


game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

CSV.foreach(game_path) do |row|
  p row
end

