# class GameStats
#   attr_reader :game_collection,
#               :game_team_collection,
#               :team_collection
#
#   def initialize(game_collection, game_team_collection, team_collection)
#     @game_collection = game_collection
#     @game_team_collection = game_team_collection
#     @team_collection = team_collection
#   end
#
#   def highest_total_score
#     sum_total_score = []
#     @game_collection.games_array.each do |game|
#       sum_total_score << game.away_goals.to_i + game.home_goals.to_i
#     end
#     sum_total_score.max
#   end
# end
