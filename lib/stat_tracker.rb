class StatTracker 
    attr_reader :locations, 
                :games_array,
                :teams_array,
                :game_teams_array

  def initialize(locations)
    @locations = locations
    @games_array = []
    @teams_array = []
    @game_teams_array = []
  end

    def self.from_csv(locations)
      CSV.foreach(locations[:games], headers: true) do |info|
        @games_array << Game.new(info)
      end
      CSV.foreach(locations[:teams], headers: true) do |info|
        @teams_array << Teams.new(info)
      end
      CSV.foreach(locations[:game_teams], headers: true) do |info|
        @game_teams_array << GameTeams.new(info)
      end
    end
end


# def initialize(locations)
#   # This instance of StatTracker will hold all of 
#   # the information you need for the methods included 
#   # in the remainder of the project description.
#   games_array = []
#   teams_array = []
#   game_teams_array = []
# require 'pry'; binding.pry
#   # maybe this makes sense:
#   CSV.foreach(locations[:games], headers: true) do |info|
#     games_array << Game.new(info)
#   end

#   # general idea: 
#   CSV.foreach(locations[:teams]) do
#     teams_array << teams
#   end

#   # general idea: 
#   CSV.foreach(locations[:game_teams]) do
#     game_teams_array << game_teams
#   end
# end
# require 'pry'; binding.pry
#   def self.from_csv(locations)
#      new(locations)
#      require 'pry'; binding.pry
#   end