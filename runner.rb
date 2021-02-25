require 'CSV'
require './test/test_helper.rb'

game_path = './data/games_truncated.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams_truncated.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)



# require 'pry'; binding.pry
