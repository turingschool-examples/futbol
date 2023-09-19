require 'csv'
require './lib/stat_tracker'
require './data/games_fixture'
require './data/teams_fixture'
require './data/game_team_fixture'

game_path = './data/games_fixture.csv'
team_path = './data/teams_fixture.csv'
game_teams_path = './data/game_team_fixture.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

require 'pry'; binding.pry