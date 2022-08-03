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

p stat_tracker.highest_scoring_home_team
p stat_tracker.lowest_scoring_home_team
p stat_tracker.most_accurate_team("20142015")
p stat_tracker.most_goals_scored("18")
p stat_tracker.best_offense


