require 'csv'

class StatTracker
   def self.from_csv(location)

      StatTracker.new(location)
   end

   def initialize(locations)
      @data_game = read_games_csv(locations[:games])
      @data_teams = read_teams_csv(locations[:teams])
      @data_game_teams = read_game_teams_csv(locations[:game_teams])
   end

end