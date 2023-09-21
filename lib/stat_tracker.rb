
# require_relative './spec_helper'


class StatTracker
  attr_reader :locations, :teams_data, :game_data, :game_team_data
  
  def initialize(locations)
    @locations = locations 
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    #@teams_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    #@game_team_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def create_game(path)
    
    
  end

  def self.from_csv(path)
    StatTracker.new
  end


  def percentage_calculator(portion, whole)
    percentage = (portion/whole).round(2)
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

  def most_tackles
    #sort season by team_id
    #use teams csv team id, sort through teams and store tackles.sum in array

    end
  end

  def least_tackles

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def count_of_teams

  end

end

  