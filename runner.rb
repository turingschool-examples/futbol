require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.new(locations)

# methods for demostrating

puts "worst coach for season 20122013:"
puts stat_tracker.worst_coach("20122013")
puts "---\n"

puts "winningest coach for season 20162017"
puts stat_tracker.winningest_coach("20162017")
puts "---\n"

puts "most accurate team ratio of shots to goals for season 20152016"
puts stat_tracker.most_accurate_team("20152016")
puts "---\n"


require 'pry'; binding.pry