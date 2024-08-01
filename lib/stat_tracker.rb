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

    def best_offense
        score_tracker = Hash.new(0)

        @game_stats_data.each do |game_id, game|
            score_tracker[game.away_team_id] = game.away_goals
            score_tracker[game.home_team_id] = game.home_goals
            require 'pry'; binding.pry
        end
        # iterate through the data
        # make an accumulator to track goals/game for each team id
        # counter = [], counter += game.goals
        # counter / games played = avg goals per game
        # find team that is associated with the highest avg goals per game
        #
        # lastly make method to associate team id in game with team id in teams
        # and return teams_dummy.teamname.to_s
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