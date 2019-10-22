require_relative './test/test_helper'
require_relative './lib/stat_tracker'

# Using dummy data files for now, change later
game_path = './data/dummy_games.csv'
team_path = './data/dummy_teams.csv'
game_teams_path = './data/dummy_game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require "pry"; binding.pry
