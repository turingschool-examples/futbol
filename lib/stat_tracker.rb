require_relative './stat_tracker'
require 'csv'
class StatTracker

  # def self.from_csv(locations)
  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
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
    @games.each do |row|
      score = row[:home_goals].to_i + row[:away_goals].to_i
      min = [min, score].min
    end
    min
  end

  def average_goals_by_season
    avg_goals = Hash.new { |hash, key| hash[key] = Hash.new(0) }
  
    @games.each do |game|
      season = game[:season].to_i
      goals = game[:home_goals].to_i + game[:away_goals].to_i
      
      avg_goals[season][:goals] += goals
      avg_goals[season][:games] += 1
    end
    
    avg_goals.transform_values do |stats|
      stats[:goals].fdiv(stats[:games]).round(2)
    end
  end
end