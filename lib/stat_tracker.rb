require './lib/game_stat_collection'
require 'csv'

class StatTracker

    def self.from_csv(locations)
      StatTracker.new(locations)
    end

    def initialize(locations)
      @game_path = locations[:games]
      @team_path = locations[:teams]
      @game_teams_path = locations[:game_teams]
    end

    def game
      GameStatCollection.new(@game_path)
    end

    def team
      TeamCollection.new(@team_path)
    end 
end
