require './lib/stat_tracker'
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

#stat_tracker.game_teams[0][:result]
#stat_tracker.teams[0][:team_id]
#stat_tracker.games[0][:date_time]
 
require 'pry' ; binding.pry


