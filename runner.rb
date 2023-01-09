require 'csv'
require './lib/stat_tracker'
require './lib/game_stats'
require './lib/league_stats'
require './lib/season_stats'
require './lib/team_stats'
require './lib/obj_game'
require './lib/obj_gameteam'
require './lib/obj_team'
require './lib/statistics_module'
require './lib/stats'



game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
