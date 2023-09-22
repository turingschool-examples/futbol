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

puts "Game Statistics"
puts "-----------------"
puts "This is the highest total score: " + "#{stat_tracker.highest_total_score}"
puts "This is the percentage ties: " + "#{stat_tracker.percentage_ties}"
puts "This is the average goals per game: " + "#{stat_tracker.average_goals_per_game}"
puts "This is a hash of the average goals per season: " + "#{stat_tracker.average_goals_by_season}"

puts "League Statistics"
puts "-----------------"
puts "This is the total count of teams: " + "#{stat_tracker.count_of_teams}"
puts "This is the team with the best offense: " + "#{stat_tracker.best_offense}"
puts "This is the highest scoring home team: " + "#{stat_tracker.highest_scoring_home_team}"
puts "This is the lowest scoring visitor: " + "#{stat_tracker.lowest_scoring_visitor}"

puts "Season Statistics"
puts "-----------------"
puts "This is the most accurate team in the 2013/2014 season: " + "#{stat_tracker.most_accurate_team("20132014")}"
puts "This is the least accurate team in the 2013/2014 season: " + "#{stat_tracker.least_accurate_team("20132014")}"
puts "This is the team with the most tackles in the 2013/2014 season: " + "#{stat_tracker.most_tackles("20132014")}"
puts "This is the team with the fewest tackles in the 2013/2014 season: " + "#{stat_tracker.fewest_tackles("20132014")}"