
# require_relative './spec_helper'


class StatTracker
  attr_reader :locations, :teams_data, :game_data, :game_team_data
  
  def initialize(locations)
    @locations = locations 
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    #@teams_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    #@game_team_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end
  

  def self.from_csv(locations)
    contents = CSV.open locations[:games], headers: true, header_converters: :symbol
    contents.each do |row|
      row
      require 'pry'; binding.pry
    end
    # StatTracker.new
  end


  def percentage_calculator(portion, whole)
    percentage =(portion/whole).round(2)
  end

  def percentage_ties 
    total_games = 0
    tied_games = 0
    @game_data.each  do |row|
    total_games += 1.00
    tied_games += 1.00 if row[:away_goals].to_f == row[:home_goals].to_f
    end
    percentage_calculator(tied_games, total_games)
  end

end

  