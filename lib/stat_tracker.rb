require 'csv'

class StatTracker
  attr_reader :locations,
              :games_data,
              :teams_data,
              :game_teams_data

  def initialize(locations)
    @locations = locations
    @games_data = CSV.open(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.open(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.open(@locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    new_stat_tracker = StatTracker.new(locations)#games_data, teams_data, game_teams_data)
  end

  # highest_total_score	Highest sum of the winning and losing teams’ scores	Integer  

  def highest_total_score
    scores = @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i 
    end
    scores.max
  end


end
