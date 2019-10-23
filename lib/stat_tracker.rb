<<<<<<< HEAD
require './lib/game_stat_collection'
require './lib/team_collection'
=======
require './lib/game_collection'
>>>>>>> d9e817c49f46b3bb20991431d4a0e2adbfde983f
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
