require_relative './test/test_helper'
require_relative './lib/stat_tracker'

# Using dummy data files for now, change later

file_paths = {
  games: './data/dummy_games.csv',
  teams: './data/dummy_teams.csv',
  game_teams: './data/dummy_games_teams.csv'
}

stat_tracker = StatTracker.from_csv(file_paths)

require "pry"; binding.pry

# open coverage/index.html

# bundle exec rspec
