require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'
require 'csv'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

game_teams_array = stat_tracker.game_teams
game_teams_array.game_teams_instances.first

team_array = stat_tracker.team
team_array.team_instances.first

game_array = stat_tracker.game

games = game_array.game_instances
home_goals = games.sum {|game| game.home_goals.to_i}
away_goals = games.sum {|game| game.away_goals.to_i}
total_games = games.size
average_goals_per_game = (home_goals + away_goals) / total_games
