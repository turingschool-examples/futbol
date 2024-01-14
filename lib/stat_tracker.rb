require_relative './stat_tracker_calculator'

class StatTracker < StatTrackerCalculator

    attr_accessor :game_path, 
                  :team_path,
                  :game_teams_path

    def initialize
        @game_path = ""
        @team_path = ""
        @game_teams_path = "" 
      end
    
      def make_factories
        @game_factory = GameFactory.new(@game_path)
        @team_factory = TeamFactory.new(@team_path)
        @game_teams_factory = GameTeamFactory.new(@game_teams_path)
      end
    
      def use_factories
        @game_factory.create_games
        @team_factory.create_teams
        @game_teams_factory.create_game_team
      end
    
      def self.from_csv(locations)
        stat_tracker = StatTracker.new
        stat_tracker.game_path = locations[:games]
        stat_tracker.team_path = locations[:teams]
        stat_tracker.game_teams_path = locations[:game_teams]
        stat_tracker.make_factories
        stat_tracker.use_factories
        stat_tracker
      end  
end