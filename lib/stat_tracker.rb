require_relative './stat_tracker'
require 'csv'
class StatTracker

  # def self.from_csv(locations)
  def initialize(locations)
    @games = CSV.open locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.open locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
  end
  # end
  
  def highest_total_score
    max = 0
    @games.each do |row|
      total = row[:home_goals].to_i + row[:away_goals].to_i
      max = [max, total].max
    end
    max
  end
  
  def lowest_total_score
    min = 10
    require 'pry'; binding.pry
    @games.each do |row|
      require 'pry'; binding.pry
      score = row[:home_goals].to_i + row[:away_goals].to_i
      min = [min, score].min
    end
    min
  end
end