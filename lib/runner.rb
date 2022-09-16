require './lib/stat_tracker'
require "./lib/team"

game_path = './data/games_dummy_2.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

p stat_tracker.count_of_teams

p stat_tracker.highest_total_score

