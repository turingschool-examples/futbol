require 'csv'

class StatTracker

    def self.from_csv(season_data)
        game_reader(season_data[:games])
        teams_reader(season_data[:teams])
        games_and_teams_reader(season_data[:game_teams])
    end

    def self.game_reader(csv_data)
        games = Hash.new(0)
        CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
            games[row[:game_id]] = Game.new(row)
        end
    end
    
    def self.teams_reader

    end
    
    def self.game_teams_reader

    end
end