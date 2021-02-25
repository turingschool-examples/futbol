require './lib/stat_tracker'
require './lib/team_table'
require './lib/game_table'
require './lib/game_team_tables'


game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path,
  #teams_test: './data/teams_test.csv'
}

stat_tracker = StatTracker.new(locations)
#stat_tracker.from_csv(locations)
#tracker = StatTracker.new(locations)
require 'pry'; binding.pry
# teams = TeamsTable.new(stat_tracker[:teams])
# stat_track = StatTracker.new
# games = GameTable.new(stat_tracker[:games])
# game_teams = GameTeamTable.new(stat_tracker[:game_teams])
# data = {team_id: 0, average: 0}
# p game_teams.game_team_data.each{|game| game}
# #stat_track.team_instantiate

