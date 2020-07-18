require "CSV"
require_relative "./game"

class StatTracker
  ## This -below- is the class method (indicated by the self.)
  def self.from_csv(locations) ##locations is a hash of the file paths.
    all_games = []
    games = CSV.foreach(locations[:games], :headers => true) do |row| ## this is our array of games

      all_games << Game.new(row)
    end
    
    StatTracker.new(all_games) ## this is creating an instance of the class
  end

  def initialize(games)
    @games = games.to_a
  end

  def highest_total_score
    #  @games[0]["home_goals"].to_i + @games[0]["away_goals"].to_i
    output = @games.max_by do |game|
      game.total_game_score
    end
    output.total_game_score
  end




end






# class StatTracker
#  attr_reader  :locations
#   def self.from_csv(locations)
#     StatTracker.new(locations)
#     # game = CSV.foreach(locations[:games]) do |row|
  
#     # end

#     game = CSV.foreach(locations[:games], :headers => true)
#     game = game.to_a
#     x = game.find {|game| game["date_time"] == "5/16/13"; puts game["venue"] }
#     require "pry"; binding.pry
    
    



#   end

  

# end

# =begin
# require "CSV"
# class StatTracker
#  attr_reader  :locations
#   def self.from_csv(locations)
#     StatTracker.new(locations)
#     # game = CSV.foreach(locations[:games]) do |row|
  
#     # end

#     game = CSV.read(locations[:games])

#     require "pry"; binding.pry

#   end

#   def initialize(locations)
#     @locations = locations
#   end

# end  
# =end
