require "csv"

class Game 
  attr_reader :game_data

  def initialize(data)
    @game_data = data
  end

  def game_count
    game_count = 0
    games = CSV.open "./data/game_teams.csv", headers: true, header_converters: :symbol
    games.each do |game|
      game_count += 1
    end
    game_count
  end


  def percentage_home_wins
    wins = 0
    games = CSV.open "./data/game_teams.csv", headers: true, header_converters: :symbol
    games.each do |line|
      if line[:hoa].include?("home")
        if line[:result].include?("WIN")
          wins += 1
        end
      end
    end
    percentage = wins / game_count.to_f
    percentage
    require 'pry'; binding.pry
  end

  def percentage_away_wins
    wins = 0
    games = CSV.open "./data/game_teams.csv", headers: true, header_converters: :symbol
    games.each do |line|
      if line[:hoa].include?("away")
        if line[:result].include?("WIN")
          wins += 1
        end
      end
    end
    percentage = wins / game_count.to_f
    percentage
  end
end
