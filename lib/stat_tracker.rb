require_relative '../spec/spec_helper'
require '../lib/game'

class StatTracker 

    attr_reader :data, :games

  def initialize(data)
    @data = data
    @games = create_games(@data[:games])
  end

  def self.from_csv(locations)
    new_locations = {}
    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end
    new(new_locations)
  end
  
  def processed_teams_data(locations)
    teams = locations[:teams]
    teams.each do |team|
      require 'pry'; binding.pry
      CSV.open team, headers: true, header_converters: :symbol
      
    end
    teams
  end
     
   
      
    

    


  def create_games(game_data)
    all_games = []
    game_data.each do |row|
      all_games << Game.new(row)
    end
    all_games
  end

end
#   def initialize(locations)
#     @games = processed_game_data(locations[:games])
#     # @teams = processed_teams_data(locations[:teams])
#     # @game_teams = processed_game_teams_data(locations[:game_teams])
#   end

#   def processed_game_data(game_data)
#     all_games = []
#     parsed_data = CSV.open game_data, headers: true, header_converters: :symbol
#     parsed_data.each do |game_info|
#       all_games << Game.new(game_info)
#     end
#     all_games
#   end

