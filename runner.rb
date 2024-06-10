require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

# Display Highest Total Score
puts "Highest Total Score: #{stat_tracker.highest_total_score}"

# Display Lowest Total Score
puts "Lowest Total Score: #{stat_tracker.lowest_total_score}"

# Display Best Offense Team
puts "Best Offense Team: #{stat_tracker.best_offense}"
