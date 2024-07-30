require 'csv'

class StatTracker

    def self.from_csv(season_data)
        game_reader(season_data[:games])
        teams_reader(season_data[:teams])
        games_and_teams_reader(season_data[:game_teams])
    end

    def self.game_reader
        
    end
    
    def self.teams_reader

    end
    
    def self.game_teams_reader

    end
end