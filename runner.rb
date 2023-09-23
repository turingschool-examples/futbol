require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
puts Benchmark.measure {
  @stat_tracker = StatTracker.from_csv(locations)
}
hash = {}


  pp @stat_tracker.teams[0].seasons


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