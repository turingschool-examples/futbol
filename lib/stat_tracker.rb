require './lib/game_stat_collection'

class StatTracker

    def self.from_csv(locations)
      game_path = locations[:games]
      team_path = locations[:teams]
      game_teams_path = locations[:game]
      StatTracker.new(game_path, team_path, game_teams_path)
    end

    def initialize(game_path, team_path, game_teams_path)
      @game_path = game_path
      @team_path = team_path
      @game_teams_path = game_teams_path
    end

    def game
      GameStatCollection.new(@game_path)
    end
end
