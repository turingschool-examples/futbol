# require './spec/spec_helper'
require_relative './spec_helper'
game_path = './data/games_dummy.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams_dummy.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
