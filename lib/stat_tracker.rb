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
        ((win_count.to_f / @game_stats_data.length)).round(2)
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

    def count_of_teams
       @teams_stats_data.size
    end
   
    def best_offense

        teams_goals = Hash.new(0)
        games_played = Hash.new(0)

        @seasons_stats_data.each do |game_id, season|
            teams_goals[season.team_id] += season.goals
            games_played[season.team_id] += 1
        end

        best_offense_team = teams_goals.max_by do |team_id, goals|
            goals.to_f / games_played[team_id].to_f
        end

        best_offense_team_id = best_offense_team[0]

        id_to_name(best_offense_team_id)
    end

    def id_to_name(id)
        @teams_stats_data.each do |team_id, team|
            return team.team_name.to_s if team_id == id
        end
    end
    
    # def worst_offense

    # end
    
    def highest_scoring_visitor
        visitor_team_scores = {}
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
    
    def lowest_scoring_visitor
        teams_goals = Hash.new(0)
        games_played = Hash.new(0)

        @game_stats_data.each do |game_id, game|
            teams_goals[game.away_team_id] += game.away_goals
            games_played[game.away_team_id] += 1
        end

        worst_visitors = teams_goals.min_by do |team_id, away_goals|
            away_goals.to_f / games_played[team_id].to_f
        end

        worst_visitor_id = worst_visitors[0]
        id_to_name(worst_visitor_id)
    end
    
    # def lowest_scoring_home_team

    # end

    # def winningest_coach
        
    # end
    
    def worst_coach
        # use game_teams.
        # similar test structure as BO / LSV
        # compare team id to winn vs loss
        #make helper method to take team 1d and return coach
        #helper method test should iterate over game_teams
        #

    end
    
    # def most_accurate_team

    # end
    
    def least_accurate_team(specific_season)
        specific_season_integer = specific_season.to_i
        games_in_season = {specific_season => []}
        @game_stats_data.each do |game_id, game_object|
            games_in_season[specific_season].push(game_id) if game_object.season == specific_season_integer
        end

        team_goal_ratio = {}

        @seasons_stats_data.each do |game_key, game_object|
            if games_in_season[specific_season].include?(game_object.game_id)
                if !(team_goal_ratio.keys.include?(game_object.team_id))
                    if game_object.shots > 0
                        team_goal_ratio[game_object.team_id] = []
                        team_goal_ratio[game_object.team_id].push((game_object.goals / game_object.shots.to_f).truncate(2))
                    else 
                        team_goal_ratio[game_object.team_id].push(0.00)
                    end
                else
                    if game_object.shots > 0
                        team_goal_ratio[game_object.team_id].push((game_object.goals / game_object.shots.to_f).truncate(2))
                    else 
                        team_goal_ratio[game_object.team_id].push(0.00)
                    end
                end
            end
        end

        lowest_accuracy_team = team_goal_ratio.min_by do |team, accuracy_per_game|
            accuracy_per_game.sum / accuracy_per_game.length
        end
        
        @teams_stats_data.each  do |team_id, team_object|
            if lowest_accuracy_team[0] == team_id
                return team_object.team_name
            end
        end
    end
    
    # def most_tackles

    # end
    
    def fewest_tackles(specific_season)
        specific_season_integer = specific_season.to_i
        games_in_season = {specific_season => []}
        @game_stats_data.each do |game_id, game_object|
            games_in_season[specific_season].push(game_id) if game_object.season == specific_season_integer
        end

        team_total_tackles = {}

        @seasons_stats_data.each do |game_key, game_object|
            if games_in_season[specific_season].include?(game_object.game_id)
                if !(team_total_tackles.keys.include?(game_object.team_id))
                    team_total_tackles[game_object.team_id] = 0
                    team_total_tackles[game_object.team_id] += game_object.tackles
                else
                    team_total_tackles[game_object.team_id] += game_object.tackles
                end
            end
        end
        lowest_tackling_team = team_total_tackles.min_by do |team_id, tackles|
            tackles
        end

        @teams_stats_data.each  do |team_id, team_object|
            if lowest_tackling_team[0] == team_id
                return team_object.team_name
            end
        end
    end
end