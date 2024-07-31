require 'csv'
require './lib/game'
require './lib/team'
require './lib/season'

class StatTracker

    def self.from_csv(season_data)
        games = game_reader(season_data[:games])
        teams =  teams_reader(season_data[:teams])
        seasons = game_teams_reader(season_data[:game_teams])
        game_stats = GameStatistics.new(games),
    end

    def self.game_reader(csv_data)
        games = Hash.new(0)
        CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
            games[row[:game_id].to_i] = Game.new(row) 
        end
        games
    end
    
    def self.teams_reader(csv_data)
        teams = Hash.new(0)
        CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
            teams[row[:team_id].to_i] = Team.new(row)
        end
        teams
    end
    
    def self.game_teams_reader(csv_data)
        seasons = Hash.new(0)
        CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
            seasons[row[:game_id].to_i] = Season.new(row)
        end
        require'pry';binding.pry
        seasons
    end
end