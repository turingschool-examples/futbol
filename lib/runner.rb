require './lib/stat_tracker'
require 'CSV'

game_path = './data/games_fixture.csv'
team_path = './data/teams_fixture.csv'
game_teams_path = './data/game_teams_fixture.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
puts stat_tracker.game_data
