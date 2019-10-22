require "csv"
require 'lib/stat_tracker'

contents = CSV.open './data/games.csv', headers: true, header_converters: :symbol
contents.foreach do |row|
  game_id = row[:game_id]
  team_id = row[:team_id]
  puts test
  # "#{game_id} #{team_id}"
end
