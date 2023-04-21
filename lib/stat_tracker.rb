require 'csv'
require_relative 'game' 
require_relative 'teams' 

class StatTracker
  # attr_reader :highest_total_scored
  def initialize(data_hash)
    @games = data_hash[:games]
  
  end


  def self.from_csv(database_hash)
    data_hash = {}
    game_array = []
    team_array = []
    database_hash.map do |key, value| 
      data_hash[key] = CSV.read(value, headers: true, header_converters: :symbol)
      data_hash.each do |key, data| 
        if key == :games
          data.each do |row|
           require 'pry'; binding.pry
          end
        end
      end
        
      
      # if key == :games
      #   game_data_method(value)
    end
  end

  #       if key == :games
  #         games = 
  #           one_game = Game.new(
  #                 row[:game_id],
  #                 row[:season],CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
  #                 row[:type],
  #                 row[:away_team_id],
  #                 row[:home_team_id],
  #                 row[:away_goals,],
  #                 row[:home_goals],
  #                 row[:venue]
  #           )
  #         # data_hash[:teams] = team_array
  #       else 
  #         teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).map do |row|
  #           one_team = Team.new(
  #             row[:team_id],
  #             row[:franchiseid],
  #             row[:teamname],
  #             row[:stadium]
  #           )
  #         end
  #       end
  #     end
  #   end
  # end
    
  #   # first iterate through database and access whichever one you want
  #   data_hash = {}
  #   game_array = []
  #   team_array = []

  #   games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
  #     one_game = Game.new(
  #           row[:game_id],
  #           row[:season],
  #           row[:type],
  #           row[:away_team_id],
  #           row[:home_team_id],
  #           row[:away_goals,],
  #           row[:home_goals],
  #           row[:venue]
  #     )
  #   end
  #   teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).map do |row|
  #     one_team = Team.new(
  #       row[:team_id],
  #       row[:franchiseid],
  #       row[:teamname],
  #       row[:stadium]
  #     )
  #   end
  #   team_array << teams
  #   data_hash[:teams] = team_array.flatten 
  #   # game_teams = CSV.read(database_hash[:game_teams], headers: true, header_converters: :symbol).map do |row|
  #   # end
  #   game_array << games
  #   data_hash[:games] = game_array.flatten 
  
  #   new(data_hash)
  # end



  def highest_total_score

   
  end



end