require 'csv'
require './lib/stat_tracker'


games = []
contents = CSV.foreach './data/games.csv', headers: true, header_converters: :symbol do |row|

contents.map.do |row|
  Game.new(stats)

end
puts games.first
