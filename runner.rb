require 'csv'
require './lib/team'
require './lib/game'

csv_teams = CSV.read("./data/teams.csv", headers: true, header_converters: :symbol)
csv_teams.map do |row|
  puts row
end

#How to create instances of Team from the teams.csv
csv_teams = CSV.read("./data/teams.csv", headers: true, header_converters: :symbol)
csv_teams.map do |row|
  Team.new(row)
end

#How to create instances of Game from the games.csv
csv_games = CSV.read("./data/games.csv", headers: true, header_converters: :symbol)
csv_games.map do |row|
  Game.new(row)
end

#how to create instances of GameTeams from games_teams.csv
csv_game_teams = CSV.read("./data/game_teams.csv", headers: true, header_converters: :symbol)
require "pry"; binding.pry
csv_games.map do |row|
  GameTeam.new(row) #gameteam class still needs to be built
end
