# runner.rb
 require './lib/stat_tracker'
 require 'csv'

 game_path = './data/games.csv'
 team_path = './data/teams.csv'
 game_teams_path = './data/game_teams_test.csv'

 filenames = {
   games: game_path,
   teams: team_path,
   game_teams: game_teams_path
 }

stat_tracker = StatTracker.from_csv(filenames)

# p stat_tracker.all_coaches
# p stat_tracker.game_teams[0].game_id

puts stat_tracker.winningest_coach
puts stat_tracker.worst_coach






##### NEED TO FIX
# if a coach is winless - won't return for worst coach
# correct for ties - can lump in with losses
