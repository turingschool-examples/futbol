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

puts stat_tracker.highest_scoring_home_team
puts stat_tracker.lowest_scoring_home_team
puts stat_tracker.most_accurate_team("20142015")
puts stat_tracker.most_goals_scored("18")
puts stat_tracker.best_offense


