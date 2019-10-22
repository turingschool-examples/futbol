require_relative './test/test_helper'
require_relative './lib/stat_tracker'

# Using dummy data files for now, change later

locations = {
  games: './data/dummy_games.csv',
  teams: './data/dummy_teams.csv',
  games_teams: './data/dummy_games_teams.csv'
}

stat_tracker = StatTracker.from_csv(locations)

require "pry"; binding.pry
