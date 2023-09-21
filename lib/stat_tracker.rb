
# require_relative './spec_helper'
 require_relative './game'



class StatTracker
  attr_reader :locations, :teams_data, :game_data, :game_team_data
  
  def initialize(locations)
    @game_data = create_games(locations[:games])
    # require 'pry'; binding.pry
    # @locations = locations 
    # @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    #@teams_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    #@game_team_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end
  
  def create_games(path)
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    # data.map { |row| Game.new(row) } 
    data.map do |row| 
    Game.new(row)
    end
    
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
  
  
  def percentage_calculator(portion, whole)
    percentage =(portion/whole).round(2)
  end
  
  def percentage_ties 
    ties = @game_data.count do |game|
     game.away_goals.to_f == game.home_goals.to_f
    end.to_f
    (ties/@game_data.count).round(2)
  end

  def 
end

  