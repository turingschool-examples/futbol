require 'csv'
require 'simplecov'
require './lib/stat_tracker'

SimpleCov.start

class GameStats
  attr_reader :game_data
  def initialize(game_data)
    #@game_data = CSV.read("./data/sample_games.csv")
  end

  def highest_total_score
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    max_score = 0
    @game_data.each do |game|
      sum = game["away_goals"].to_i + game["home_goals"].to_i
      if sum > max_score
        max_score = sum
      end
    end
    max_score
  end
end
