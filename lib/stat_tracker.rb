require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(locations)
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end
end