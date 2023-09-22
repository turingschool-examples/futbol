# runner.rb
require './spec/spec_helper'

# game_path = './data/games.csv'
# team_path = './data/teams.csv'
# game_teams_path = './data/game_teams.csv'

game_path = './data/test_games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/test_game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry