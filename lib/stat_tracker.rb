require_relative '../spec/spec_helper'

class StatTracker 

    attr_reader :data, :teams

  def initialize(data)
    @data = data
    @teams = teams
  end
  
  def self.from_csv(locations)
    new_locations = {}
    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end
    new(new_locations)
  end
  
  def processed_teams_data(locations)
    all_teams = []
    teams = @data[:teams]
    teams.each do |row|
      all_teams << Team.new(row)
    end
    @teams = all_teams
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

