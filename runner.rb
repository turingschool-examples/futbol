# runner.rb
require 'csv'
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
# require 'pry'; binding.pry



stat_tracker[0].read_game_stats(game_path)
stat_tracker[0].read_team_stats(team_path)
stat_tracker[0].read_game_teams_stats(game_teams_path)

stat_tracker[0].highest_total_score
# require 'pry'; binding.pry
