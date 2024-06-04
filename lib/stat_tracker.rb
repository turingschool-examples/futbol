require 'csv'
require_relative 'league'
require_relative 'game'
require_relative 'season'

class StatTracker
    attr_reader :game_data, :team_data, :game_teams_data, :game, :league, :season
    def initialize(locations)
        @game_data = CSV.read(locations[:games], headers: true)
        @team_data = CSV.read(locations[:teams], headers: true)
        @game_teams_data = CSV.read(locations[:game_teams], headers: true)

        @game = Game.new(@game_data)
        # @league = League.new(@team_data, @game_teams_data)
        # @season = Season.new(@game_data, @game_teams_data)
    end

    #class method, allows us to create a new instance of StatTracker directly from a CSV file location.
    def self.from_csv(locations) 
        StatTracker.new(locations)
    end
end
