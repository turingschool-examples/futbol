# def season_names
#   @season_name = @games.map do |game|
#     game.season
#   end.uniq
#   @season_name
# end
#
# def season_games(season_id)
#   @games.select do |game|
#     game.season == season_id
#   end.count
# end #this works!!! need to make dynamic
#
# def count_of_games_by_season
#   games_per_season = {}
#     @season_name.each do |season|
#       season_games(season)
#         games_per_season["#{season}"] = season_games(season)
#     end
#     games_per_season
#   end #to make an interpolated symbol -- games_per_season[:"#{season}"
