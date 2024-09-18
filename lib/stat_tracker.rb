require 'csv'
require_relative 'game'
class StatTracker
    attr_reader :locations,
                :league_statistics
    
    def self.from_csv(locations)
        StatTracker.new(locations)
    end

    def initialize(locations)
        games              = create_games(locations[:games])
        require 'pry'; binding.pry
        teams              = locations[:teams] 
        game_teams         = locations[:game_teams]
        
        @league_statistics = LeagueStatistics.new(games,teams)
    end

    def create_games(path) #creating a method called create games that takes the argument of path which is a strign
        csv_table = CSV.parse(File.read(path), headers: true) #creating called data that reads the path file and identifies it has headers and we parse into a CSV table "array of hashes"
        csv_table.map do |row| #iterating through each row of the data table
            Game.new(row) #Each row  in the table creates a new Game instnace
        end #Returns an array of game instances
    end
end