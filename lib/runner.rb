require './lib/stat_tracker'
require "./lib/team"
require "./lib/game"

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

# p stat_tracker.games

# p stat_tracker.highest_total_score
# p stat_tracker.count_of_games_by_season
require "pry"; binding.pry