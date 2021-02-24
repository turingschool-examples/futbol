# runner.rb

require './lib/stat_tracker'

game_path = './fixture/games_dummy15.csv'  #'./data/games.csv'
team_path = './fixture/teams_dummy15.csv'
game_teams_path = './fixture/game_teams_dummy15.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

#require 'pry'; binding.pry
