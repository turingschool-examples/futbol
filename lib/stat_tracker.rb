
# require_relative './spec_helper'
 require_relative './game'



class StatTracker
  attr_reader :locations, :teams_data, :game_data, :game_teams_data
  
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
    Game.games.group_by {|game| game.season}
    require 'pry'; binding.pry
    #sort season by team_id
    #use teams csv team id, sort through teams and store tackles.sum in array
    #find max value in array
    #find team id that matches max value
    #return team name and max value
  end

  def least_tackles

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def count_of_teams

  end


  def average_goals_per_game
    total_goals = 0
    total_games = []
    @game_teams_data.each do |row|
      total_goals += row[:goals].to_i
      total_games << row[:game_id]
    end
    average = total_goals.to_f / total_games.uniq.count
    average.round(2)
  end

  

  # def highest_scoring_visitor
  #   team_information = {}
  #   season_goals = 0
  #   @game_teams_data.find_all do |row|
  #     season_goals += row[:goals].to_i
  #     team_information[row[:team_id]] = season_goals + 
  #     # require 'pry'; binding.pry
  #   # require 'pry'; binding.pry
  #   # row[:goals]
  #   # row[:team_id]
  #   # row[:game_id]
  #   # row[:hoa]
  
  # end
    
  #   #Turns it into hash
  #   # teams = @game_teams_data.group_by { |row| row[:team_id]}
  #   # # require 'pry'; binding.pry

  #   #turns it into array
  #   # teams.each do |row|
  #   #   team_id = row.shift


  #   # end 
  # end
end

  
  


  