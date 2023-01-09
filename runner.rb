require 'csv'
require './lib/stat_tracker'
require './lib/game_stats'
require './lib/indv_league'
require './lib/indv_season'
require './lib/indv_team'
require './lib/obj_game'
require './lib/obj_gameteam'
require './lib/obj_team'
require './lib/statistics_module'



game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
