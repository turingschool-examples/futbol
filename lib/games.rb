require 'csv'
require 'pry'
require_relative './stat_tracker'
class Games
  attr_reader   :game_id,
                :season,
                :type,
                :date_time,
                :home_team_id,
                :away_team_id,
                :away_goals,
                :home_goals,
                :venue,
                :venue_link
    def initialize(games_data)
      @game_id = games_data[:game_id].to_i
      @season = games_data[:season].to_i
      @type = games_data[:type]
      @date_time = games_data[:date_time]
      @away_team_id = games_data[:away_team_id].to_i
      @home_team_id = games_data[:home_team_id].to_i
      @away_goals = games_data[:away_goals].to_i
      @home_goals = games_data[:home_goals].to_i
      @venue = games_data[:venue]
      @venue_link = games_data[:venue_link]
    end

end

  

  
  #     binding.pry
 
#   # def self.from_csv(games_data)
#   #   games = CSV.foreach(locations[:games], headers: true, header_converters: :symbol)
#   # end
#   # binding.pry
  
#   def self.from_csv(file_path)
#     games = []
    
#     CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
#       games << Games.new(row)  # Create a Games object for each row
#     end
   
#     games  # Return an array of Games objects
  
#   end
#   # def 
#   #   stat_tracker = StatTracker.new(locations)
#   # end 

#   # def highest_total_score

#   # end 
    
#   #   Highest sum of the winning and losing teams’ scores	Integer
# end