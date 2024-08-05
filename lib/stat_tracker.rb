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

    def percentage_visitor_wins
        visitor_win_count = @game_stats_data.count do |game_id, game_object|
            game_object.away_goals > game_object.home_goals
        end
        (visitor_win_count.to_f / @game_stats_data.length).round(2)
    end

    def percentage_ties
        tie_count = @game_stats_data.count do |game_id, game_object|
            game_object.home_goals == game_object.away_goals 
        end
        ((tie_count.to_f / @game_stats_data.length).truncate(2))
    end

    def count_of_games_by_season
        season_game_count = Hash.new(0)
        @game_stats_data.each do |game_id, game_object|
            season = game_object.season.to_s
            season_game_count[season.to_s] += 1 
        end
        season_game_count
    end

    def average_goals_by_season
        count_of_games_by_season
        total_season_goals = Hash.new(0)
        @game_stats_data.each do |game_id, game_object|
            season = game_object.season.to_s
            goals = game_object.total_goals
            total_season_goals[season] += goals
       end
       average = total_season_goals.merge!(count_of_games_by_season) do |season, goals, games|
          (goals / games.to_f).round(2)
       end
       average
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
   
    def team_seasons_goals(location)
        
        teams_data = Hash.new { |hash, key| hash[key] = { goals: 0, games_played: 0 } }

        @seasons_stats_data.each do |game_id, season|
            if location.include?(season.hoa)
                teams_data[season.team_id][:goals] += season.goals
                teams_data[season.team_id][:games_played] += 1
            end
        end
        teams_data
    end

    def teams_scores_average_min_by(teams_data)
        lowest_scoring_team = teams_data.min_by do |team_id, team_data|
            team_data[:goals].to_f / team_data[:games_played].to_f
        end
    end

    def teams_scores_average_max_by(teams_data)
        highest_scoring_team = teams_data.max_by do |team_id, team_data|
            team_data[:goals].to_f / team_data[:games_played].to_f
        end
    end

    def best_offense
        teams_goals_data = team_seasons_goals(['home','away'])
        best_offense_team = teams_scores_average_max_by(teams_goals_data)

        best_offense_team_id = best_offense_team[0]
        id_to_name(best_offense_team_id)
    end

    def id_to_name(id)
        @teams_stats_data.each do |team_id, team|
            return team.team_name.to_s if team_id == id
        end
    end

    def worst_offense
        teams_goals_data = team_seasons_goals(['home','away'])
        worst_offense_team = teams_scores_average_min_by(teams_goals_data)
        worst_offense_team_id = worst_offense_team[0]

        id_to_name(worst_offense_team_id)
    end

    def highest_scoring_visitor
        away_teams_goals_data = team_seasons_goals('away')

        lowest_scoring_team = teams_scores_average_max_by(away_teams_goals_data)

        worst_visitor_id = lowest_scoring_team[0]
        id_to_name(worst_visitor_id)
    end
    
    def highest_scoring_home_team
        teams_home_goals = team_seasons_goals(['home'])
        best_home_team = teams_scores_average_max_by(teams_home_goals)

        best_home_team_id = best_home_team[0]
        id_to_name(best_home_team_id)
    end
    
    def lowest_scoring_visitor
        away_teams_goals_data = team_seasons_goals('away')

        lowest_scoring_team = teams_scores_average_min_by(away_teams_goals_data)

        worst_visitor_id = lowest_scoring_team[0]
        id_to_name(worst_visitor_id)
    end
    
    def lowest_scoring_home_team
        home_teams_goals_data = team_seasons_goals('home')

        lowest_scoring_team = teams_scores_average_min_by(home_teams_goals_data)

        lowest_scoring_team_id = lowest_scoring_team[0]
        id_to_name(lowest_scoring_team_id)
    end

    
    def game_id_to_coach(game_id, team_id)
        matching_season = @seasons_stats_data.find do |key, seasons_object|
            seasons_object.team_id == team_id && seasons_object.game_id == game_id
        end
        matching_season[1].head_coach
    end
    
    def win_loss_ratio(specific_season)
        specific_season_integer = specific_season.to_i
        team_win_loss_ratio = Hash.new { |hash, key| hash[key] = { win_count: 0, games_played: 0, tied_games: 0 } }
        
        @game_stats_data.each do |game_id, game_object|
            next unless game_object.season == specific_season_integer
            team_win_loss_ratio[game_id_to_coach(game_id, game_object.away_team_id)][:games_played] += 1
            team_win_loss_ratio[game_id_to_coach(game_id, game_object.home_team_id)][:games_played] += 1
            
            if game_object.home_goals > game_object.away_goals
                team_win_loss_ratio[game_id_to_coach(game_id, game_object.home_team_id)][:win_count] += 1
            elsif game_object.home_goals < game_object.away_goals
                team_win_loss_ratio[game_id_to_coach(game_id, game_object.away_team_id)][:win_count] += 1
            else
                team_win_loss_ratio[game_id_to_coach(game_id, game_object.away_team_id)][:tied_games] += 1
                team_win_loss_ratio[game_id_to_coach(game_id, game_object.home_team_id)][:tied_games] += 1
            end 
        end
        return team_win_loss_ratio
    end
    
    def winningest_coach(specific_season)
        team_win_loss_ratio = win_loss_ratio(specific_season)
        
        best_team = team_win_loss_ratio.max_by do |coach_name, result_stats|
            result_stats[:win_count].to_f / result_stats[:games_played]
        end
       
        return best_team[0]
    end
    
    def worst_coach(specific_season)
        team_win_loss_ratio = win_loss_ratio(specific_season)
        
        worst_team = team_win_loss_ratio.min_by do |coach_name, result_stats|
            result_stats[:win_count].to_f / result_stats[:games_played]
        end
       
        return worst_team[0]
    end

    def id_to_coach(id)
        @seasons_stats_data.each do |game_id, game_object|
            return game_object.head_coach if game_object.team_id == id
        end
    end
  
    # def most_accurate_team
  
    # end  

    def all_games_ids_in_specified_season(specific_season)
        
        games_in_seasons = @game_stats_data.find_all { |game_id, game_object| game_object.season == specific_season.to_i}
        game_ids_in_season = games_in_seasons.map { |game_id, game_object| game_id }
        
    end

    def teams_shots_and_goals(game_ids)
        teams_data = Hash.new { |hash, key| hash[key] = { goals: 0, shots: 0 } }

        @seasons_stats_data.each do |counter, season_object|
            
            next unless game_ids.include?(season_object.game_id)
           
            teams_data[season_object.team_id][:goals] += season_object.goals
            teams_data[season_object.team_id][:shots] += season_object.shots
        end

        teams_data
    end
   
    def most_accurate_team(specific_season)
        teams_data = teams_shots_and_goals(all_games_ids_in_specified_season(specific_season))
        
        most_accurate = teams_data.reject { |_, team_data| team_data[:shots] == 0 || team_data[:goals] == 0 }
        .max_by { |_, team_data| team_data[:goals].to_f / team_data[:shots] }
  
        id_to_name(most_accurate[0])
    end
    
    def least_accurate_team(specific_season)
        teams_data = teams_shots_and_goals(all_games_ids_in_specified_season(specific_season))
        
        most_accurate = teams_data.reject { |_, team_data| team_data[:shots] == 0 || team_data[:goals] == 0 }
        .min_by { |_, team_data| team_data[:goals].to_f / team_data[:shots] }
  
        id_to_name(most_accurate[0])
    end
    
    # def most_tackles

    # end

    def team_tackles_in_games(game_ids)
        team_total_tackles = Hash.new(0)

        @seasons_stats_data.each do |key, season_object|
            next unless game_ids.include?(season_object.game_id)
            team_total_tackles[season_object.team_id] += season_object.tackles
        end

        team_total_tackles
    end

    def fewest_tackles(specific_season)
        game_ids =  all_games_ids_in_specified_season(specific_season)
        team_total_tackles = team_tackles_in_games(game_ids)

        lowest_tackling_team = team_total_tackles.min_by { | team_id, tackles| tackles}
        id_to_name(lowest_tackling_team[0])
    end
end