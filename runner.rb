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


puts "\n\n** Game Statistics **\n"
puts "\nPercentage of games that a home team has won:"
puts stat_tracker.percentage_home_wins
# puts "\n"

puts "\nPercentage of games that a visitor has won:"
puts stat_tracker.percentage_visitor_wins
puts "\n"

puts "\n** League Statistics **\n"
puts "\nTeam with the best offense:"
puts stat_tracker.best_offense
# puts "\n"

puts "\nTeam with the worst offense:"
puts stat_tracker.worst_offense
puts "\n"

puts "\n** Season Statistics **\n"
puts "\nCoach with the best win percentage for the 2012-2013 season:"
puts stat_tracker.winningest_coach("20122013")
# puts "\n"

puts "\nCoach with the worst win percentage for the 2012-2013 season:"
puts stat_tracker.worst_coach("20122013")
puts "\n\n"

puts "\n** Team Statistics **\n"
puts "\nTeam Infor for Chicago Fire:"
puts stat_tracker.team_info("Chicago Fire")

