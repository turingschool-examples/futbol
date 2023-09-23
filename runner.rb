require './lib/stat_tracker'

game_path = './data/games_fixture.csv'
team_path = './data/teams_fixture.csv'
game_teams_path = './data/game_teams_fixture.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

hash = {}

puts Benchmark.measure {
  stat_tracker.game_teams.map {|game| game[:team_id] }
}

# puts Benchmark.measure {
# stat_tracker.game.each do |one_game|
#   hash[one_game] = (
#   stat_tracker.game_teams.find_all do |game_team|
#     game_team[:game_id] == one_game[:game_id]
#   end )
#   hash
# end
# }

require 'pry'; binding.pry