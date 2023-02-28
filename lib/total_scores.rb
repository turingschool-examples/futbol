require 'csv'
require '../lib/game_data'
require '../lib/game'

def highest_total_score
  games = CSV.open'../data/games.csv', headers: true, header_converters: :symbol
  array = []
  games.each do |row|
    score = row[:home_goals].to_i + row[:away_goals].to_i
    array << score
  end
  array.max
end

def lowest_total_score
  games = CSV.open'../data/games.csv', headers: true, header_converters: :symbol
  array = []
  games.each do |row|
    score = row[:home_goals].to_i + row[:away_goals].to_i
    array << score
  end
  array.min
end

p highest_total_score
p lowest_total_score