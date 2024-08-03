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

    def percentage_home_wins
        win_count = @game_stats_data.count do |game_id, game|
            game.home_goals > game.away_goals 
        end
        ((win_count.to_f / @game_stats_data.length)).round(2)
    end

    def percentage_ties
        tie_count = @game_stats_data.count do |game_id, game|
            game.home_goals == game.away_goals 
        end
        ((tie_count.to_f/ @game_stats_data.length).truncate(2))
    end

    # def count_of_teams

    # end
   
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
    
    # def highest_scoring_visitor
        
    # end
    
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
    
    def worst_coach(specific_season)
        specific_season_integer = specific_season.to_i

        games_in_season = {specific_season => []}
        @game_stats_data.each do |game_id, game_object|
            games_in_season[specific_season].push(game_id) if game_object.season == specific_season_integer
        end

        teams_total_results = {}
        @seasons_stats_data.each do |game_id, game_object|
            if games_in_season[specific_season].include?(game_object.game_id)
                if !(teams_total_results.keys.include?(game_object.team_id))
                    teams_total_results[game_object.team_id] = []
                    teams_total_results[game_object.team_id].push(game_object.result)
                else
                    teams_total_results[game_object.team_id].push(game_object.result)
                end
            end
        end

        team_win_ratio = {}
        teams_total_results.map do |team_id, total_results|
            
            win_counter = 0
            total_results.each do |result|
                if result == "WIN"
                    win_counter += 1
                end
            end
            team_win_ratio[team_id] = (win_counter.to_f / total_results.length).truncate(2)
        end

        worst_team = team_win_ratio.min_by do |team_id, win_ratio|
            win_ratio
        end
        id_to_coach(worst_team[0])
    end

    def id_to_coach(id)
        @seasons_stats_data.each do |game_id, game_object|
            return game_object.head_coach if game_object.team_id == id
        end
    end

  
    # def most_accurate_team

    # end
    
    # def least_accurate_team

    # end
    
    # def most_tackles

    # end
    
    # def fewest_tackles

    # end
end