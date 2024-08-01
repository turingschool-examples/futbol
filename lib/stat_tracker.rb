require 'csv'
require './lib/game'
require './lib/team'
require './lib/season'


class StatTracker
    
    def self.from_csv(season_data)
        games = game_reader(season_data[:games])
        teams =  teams_reader(season_data[:teams])
        seasons = game_teams_reader(season_data[:game_teams])

        new(games, teams, seasons)
    end

    def initialize(games, teams, seasons)
        @game_stats_data = games
        @teams_stats_data = teams
        @seasons_stats_data = seasons
    end

    def highest_total_score
        highest_scoring_game = @game_stats_data.max_by do |game_id, game_object|
            game_object.total_goals
        end
        highest_scoring_game[1].total_goals
    end

    def percentage_home_wins
        win_count = @game_stats_data.count do |game_id, game|
            game.home_goals > game.away_goals 
        end
        ((win_count.to_f / @game_stats_data.length) * 100).truncate(2)
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
        count = 1 
        CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
            seasons[count] = Season.new(row)
            count +=1 
        end
        seasons
    end

end