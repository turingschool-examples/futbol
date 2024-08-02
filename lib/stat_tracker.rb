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

    def highest_total_score
        highest_scoring_game = @game_stats_data.max_by do |game_id, game_object|
            game_object.total_goals
        end
        highest_scoring_game[1].total_goals
    end

    def lowest_total_score
        lowest_scoring_game = @game_stats_data.min_by do |game_id, game_object|
            game_object.away_goals + game_object.home_goals
        end
        lowest_scoring_game[1].total_goals
    end

    def percentage_home_wins
        win_count = @game_stats_data.count do |game_id, game_object|
            game_object.home_goals > game_object.away_goals 
        end
        ((win_count.to_f / @game_stats_data.length) * 100).truncate(2)
    end

    def percentage_ties
        tie_count = @game_stats_data.count do |game_id, game_object|
            game_object.home_goals == game_object.away_goals 
        end
        ((tie_count.to_f / @game_stats_data.length).truncate(2))
    end

    def average_goals_per_game
        total_goals_per_game = []
        @game_stats_data.each do |game_id, game_object|
            total_goals_per_game << game_object.total_goals
        end
        
        (total_goals_per_game.sum / total_goals_per_game.length.to_f).round(2)
    end

    # def count_of_teams

    # end
   
    # def best_offense

    # end
    
    # def worst_offense

    # end
    
    def highest_scoring_visitor
        visitor_team_scores = Hash.new
        @game_stats_data.each do |game_id, game_object|
            if !(visitor_team_scores.keys.include?(game_object.away_team_id))
                visitor_team_scores[game_object.away_team_id] = []
                visitor_team_scores[game_object.away_team_id].push(game_object.away_goals)
            else
                visitor_team_scores[game_object.away_team_id].push(game_object.away_goals)
            end
        end
        winning_team = visitor_team_scores.max_by do |team, scores|
            (scores.sum / scores.length.to_f).round(2)
        end
        
        @teams_stats_data.each  do |team_id, team_object|
            if winning_team[0] == team_id
                return team_object.team_name
            end
        end
    end
    
    # def highest_scoring_home_team

    # end
    
    # def lowest_scoring_visitor

    # end
    
    # def lowest_scoring_home_team

    # end

    # def winningest_coach
        
    # end
    
    # def worst_coach

    # end
    
    # def most_accurate_team

    # end
    
    # def least_accurate_team

    # end
    
    # def most_tackles

    # end
    
    # def fewest_tackles

    # end
end