require "csv"
require "../lib/game_data"
require "../lib/game"


def count_of_games_by_season
  games = CSV.open '../data/games.csv', headers: true, header_converters: :symbol
  hash = Hash.new(0)
  games.each do |row|
    if hash[row[:season]]
      hash[row[:season]] += 1
    else
      hash[row[:season]]
    end
  end
  hash
end

def average_goals_per_game
  games = CSV.open '../data/games.csv', headers: true, header_converters: :symbol
  total_games = 0
  total_goals = 0
  games.each do |row|
    if row[:game_id]
      total_games += 1
    end
    if row[:home_goals] && row[:away_goals]
      goals = row[:home_goals].to_f + row[:away_goals].to_f
      total_goals += goals.to_f
    end
  end
  average = total_goals / total_games
  average.round(2)
end

def average_goals_by_season
  games = CSV.open '../data/games.csv', headers: true, header_converters: :symbol
  goals_per_season = Hash.new(0)
  games_per_season = Hash.new(0)
  average_goals_by_season = Hash.new(0)
  games.each do |row|
    goals_per_season[row[:season]] += (row[:home_goals].to_i + row[:away_goals].to_i)

    average_goals_by_season[row[:season]] = 0

    if row[:game_id]
      games_per_season[row[:season]] += 1
    end
  end

  average_goals_by_season.each do |key, value|
    average_goals_by_season[key] = goals_per_season[key].to_f / games_per_season[key].to_f
    average_goals_by_season[key] = average_goals_by_season[key].round(2)
  end
average_goals_by_season
end

p count_of_games_by_season
p average_goals_per_game
p average_goals_by_season