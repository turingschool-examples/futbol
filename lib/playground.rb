require 'csv'
require './lib/stat_tracker'


games = []
contents = CSV.foreach './data/games.csv', headers: true, header_converters: :symbol do |row|
  hash = {}
  # game_id = row[:game_id].to_i
  # team_id = row[:team_id].to_i
  away_goals = row[:away_goals].to_i
  home_goals = row[:home_goals].to_i
  hash[:away_goals] = away_goals
  hash[:home_goals] = home_goals
  hash[:sum_goals] = away_goals + home_goals
  hash[:sesson]
games << hash

end
puts games
