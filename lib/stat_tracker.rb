require "csv"
# require_relative "array_generator"
require_relative "game"
require_relative "team"
require_relative "game_team"
require_relative "game_repo"
require_relative "team_repo"
require_relative "game_team_repo"


class StatTracker
    # include ArrayGenerator

    attr_reader :games,
                :teams,
                :game_teams

    def initialize(locations)
        @games = GameRepo.new(locations)
        @teams = TeamRepo.new(locations)
        @game_teams = GameTeamRepo.new(locations)
    end

    def self.from_csv(locations)
        StatTracker.new(locations)
    end

    def highest_total_score
       @games.highest_total_score
    end

    def lowest_total_score
        @games.lowest_total_score
    end
    
    def percentage_home_wins
        wins = []
        @games.each do |game|
            wins << game.home_wins
        end
        (wins.compact.count.to_f / @games.count.to_f).round(2)
    end

    def percentage_visitor_wins
        wins = []
        @games.each do |game|
            wins << game.visitor_wins
        end
        (wins.sum.to_f / @games.count.to_f).round(2)
    end

    def percentage_ties
        ties = []
        @games.each do |game|
            ties << game.game_ties
        end
        (ties.sum.to_f / @games.count.to_f).round(2)
    end

    def count_of_games_by_season
        season_games = Hash.new(0)
        @games.each do |game|
            season_games[game.season] += 1
        end
        season_games
    end

    def average_goals_per_game
        averages = []
        @games.each do |game|
            averages << game.game_total_score
        end
        averages.sum.to_f / (@games.count.to_f).round(2)                    
    end

    def average_goals_by_season
        season_count = @games.group_by { |game| game[:season] }
        season_count.each do |season_id, game_season|
            season_count[season_id] = (game_season.sum do |game| 
                game[:away_goals] + game[:home_goals] 
            end / game_season.count.to_f).round(2)
        end
    end
    
    def count_of_teams
        @teams.count
    end

    def best_offense
        total_goals_by_team = Hash.new(0)
        @game_teams.each do |game|
            total_goals_by_team[game[:team_id]] += game[:goals]
        end

        avg_goals_by_team = Hash.new(0)
        total_goals_by_team.each do |id, total_goals|
            avg_goals_by_team[id] = (total_goals.to_f / @game_teams.find_all { |game| game[:team_id] == id }.length).round(2)
        end
         
        @teams.find do |game|
            if game[:team_id] == avg_goals_by_team.key(avg_goals_by_team.values.max)
                return game[:teamname]
            end
        end
    end

    def worst_offense
        total_goals_by_team = Hash.new(0)
        @game_teams.each do |game|
            total_goals_by_team[game[:team_id]] += game[:goals]
        end

        avg_goals_by_team = Hash.new(0)
        total_goals_by_team.each do |id, total_goals|
            avg_goals_by_team[id] = (total_goals.to_f / @game_teams.find_all { |game| game[:team_id] == id }.length).round(2)
        end
         
        @teams.find do |game|
            if game[:team_id] == avg_goals_by_team.key(avg_goals_by_team.values.min)
                return game[:teamname]
            end
        end
    end

    def highest_scoring_visitor
        team_total_goals = Hash.new (0)
        @game_teams.each do |game|
            (team_total_goals[game[:team_id]] += game[:goals]) if game[:hoa] == "away" 
        end
        
        team_total_goals.update(team_total_goals) do |team_id, away_games|
            team_total_goals[team_id].to_f / @game_teams.find_all { |game| game[:hoa] == "away" && game[:team_id] == team_id}.length
        end
        
        highest_away_team_id = team_total_goals.key(team_total_goals.values.max)
        
        highest_away_team = @teams.find { |team| team[:teamname] if team[:team_id] == highest_away_team_id }
        highest_away_team[:teamname]
    end

    def highest_scoring_home_team
        team_total_goals = Hash.new (0)
        @game_teams.each do |game|
            (team_total_goals[game[:team_id]] += game[:goals]) if game[:hoa] == "home" 
        end
        
        team_total_goals.update(team_total_goals) do |team_id, away_games|
            team_total_goals[team_id].to_f / @game_teams.find_all { |game| game[:hoa] == "home" && game[:team_id] == team_id}.length
        end
        
        highest_home_team_id = team_total_goals.key(team_total_goals.values.max)
        
        highest_home_team = @teams.find { |team| team[:teamname] if team[:team_id] == highest_home_team_id }
        highest_home_team[:teamname]
    end

    def lowest_scoring_visitor
        team_total_goals = Hash.new (0)
        @game_teams.each do |game|
            (team_total_goals[game[:team_id]] += game[:goals]) if game[:hoa] == "away" 
        end
        
        team_total_goals.update(team_total_goals) do |team_id, away_games|
            team_total_goals[team_id].to_f / @game_teams.find_all { |game| game[:hoa] == "away" && game[:team_id] == team_id}.length
        end
        
        highest_away_team_id = team_total_goals.key(team_total_goals.values.min)
        
        highest_away_team = @teams.find { |team| team[:teamname] if team[:team_id] == highest_away_team_id }
        highest_away_team[:teamname]
    end

    def lowest_scoring_home_team
        team_total_goals = Hash.new (0)
        @game_teams.each do |game|
            (team_total_goals[game[:team_id]] += game[:goals]) if game[:hoa] == "home" 
        end
        
        team_total_goals.update(team_total_goals) do |team_id, away_games|
            team_total_goals[team_id].to_f / @game_teams.find_all { |game| game[:hoa] == "home" && game[:team_id] == team_id}.length
        end
        
        highest_home_team_id = team_total_goals.key(team_total_goals.values.min)
        
        highest_home_team = @teams.find { |team| team[:teamname] if team[:team_id] == highest_home_team_id }
        highest_home_team[:teamname]
    end

    def winningest_coach(season_id)
        games_by_coach = Hash.new { |h,k| h[k] = Hash.new(0) }
        @game_teams.each do |game_team|
            if game_team[:game_id].slice(0..3) == season_id.slice(0..3)
                coach_games = games_by_coach[game_team[:head_coach]]
                coach_games[:total_games] += 1.0
                if game_team[:result] == "WIN"
                    coach_games[:wins] += 1.0
                end
            end
        end
        win_percentage = Hash.new (0)
        games_by_coach.each do |coach_name, stats|
            win_percentage[coach_name] = stats[:wins] / stats[:total_games]
        end
        coach = win_percentage.max_by { |coach_name, win_percentage| win_percentage }[0]
    end

    def worst_coach(season_id)
        games_by_coach = Hash.new { |h,k| h[k] = Hash.new(0) }
        @game_teams.each do |game_team|
            if game_team[:game_id].slice(0..3) == season_id.slice(0..3)
                coach_games = games_by_coach[game_team[:head_coach]]
                coach_games[:total_games] += 1.0
                if game_team[:result] == "WIN"
                    coach_games[:wins] += 1.0
                end
            end
        end
        win_percentage = Hash.new (0)
        games_by_coach.each do |coach_name, stats|
            win_percentage[coach_name] = stats[:wins] / stats[:total_games]
        end
        coach = win_percentage.min_by { |coach_name, win_percentage| win_percentage }[0]
    end

    def most_accurate_team(season)
        accuracy = {}

        season_games = @game_teams.select { |game| game[:game_id][0..3] == season[0..3] }

        season_team_ids = season_games.group_by { |season_game| season_game[:team_id] }.keys

        season_teams = season_team_ids.map do |team_id|
            @teams.find do |team|
                team[:team_id] == team_id
            end[:teamname]
        end

        season_team_ids.each do |season_team_id|
            team_season_games = season_games.select { |season_game| season_game[:team_id] == season_team_id }
            team_season_goals = team_season_games.sum { |team_season_game| team_season_game[:goals] }
            team_season_shots = team_season_games.sum { |team_season_game| team_season_game[:shots] }
            accuracy[season_team_id] = team_season_goals / team_season_shots.to_f
        end

        best_team = accuracy.max_by { |team| team[1] }[0]
        @teams.find { |team| team[:team_id] == best_team }[:teamname]
    end

    def least_accurate_team(season)
        accuracy = {}

        season_games = @game_teams.select { |game| game[:game_id][0..3] == season[0..3] }

        season_team_ids = season_games.group_by { |season_game| season_game[:team_id] }.keys

        season_teams = season_team_ids.map do |team_id|
            @teams.find do |team|
                team[:team_id] == team_id
            end[:teamname]
        end

        season_team_ids.each do |season_team_id|
            team_season_games = season_games.select { |season_game| season_game[:team_id] == season_team_id }
            team_season_goals = team_season_games.sum { |team_season_game| team_season_game[:goals] }
            team_season_shots = team_season_games.sum { |team_season_game| team_season_game[:shots] }
            accuracy[season_team_id] = team_season_goals / team_season_shots.to_f
        end

        best_team = accuracy.min_by { |team| team[1] }[0]
        @teams.find { |team| team[:team_id] == best_team }[:teamname]
    end

    def most_tackles(season_id)
        season_tackles = Hash.new(0)
        season_games = @games.group_by { |game| game[:season]}

        game_id = season_games[season_id].map { |game| game[:game_id] }
       
        game_id.each do |id|
            @game_teams.each do |game_team|
                if game_team[:game_id] == id
                    season_tackles[game_team[:team_id]] += game_team[:tackles]
                end
            end
        end

        team_with_most_tackles = season_tackles.max_by do |team_tackles|
            team_tackles[1]
        end.first
        @teams.find {|team| team[:team_id] == team_with_most_tackles}[:teamname]
    end

    def fewest_tackles(season_id)
        season_tackles = Hash.new(0)
        season_games = @games.group_by { |game| game[:season]}

        game_id = season_games[season_id].map { |game| game[:game_id] }
       
        game_id.each do |id|
            @game_teams.each do |game_team|
                if game_team[:game_id] == id
                    season_tackles[game_team[:team_id]] += game_team[:tackles]
                end
            end
        end

        team_with_most_tackles = season_tackles.min_by do |team_tackles|
            team_tackles[1]
        end.first
        @teams.find {|team| team[:team_id] == team_with_most_tackles}[:teamname]
    end

    def most_goals_scored(team_id)

        game_teams_id = @game_teams.find_all { |team| team[:team_id] == team_id }
        
        game_goals_list = []
        
        game_teams_id.each do |info|
            game_goals_list << info[:goals]
        end
        
        game_goals_list.max
    end

    def fewest_goals_scored(team_id)

        game_teams_id = @game_teams.find_all { |team| team[:team_id] == team_id }
        
        game_goals_list = []
        
        game_teams_id.each do |info|
            game_goals_list << info[:goals]
        end
        
        game_goals_list.min
    end

    def team_info(team_id)
        team_info = @teams.find { |team| team[:team_id] == team_id }
        {
          'team_id' => team_info[:team_id],
          'franchise_id' => team_info[:franchiseid],
          'team_name' => team_info[:teamname],
          'abbreviation' => team_info[:abbreviation],
          'link' => team_info[:link]
        }
    end

    def best_season(team_id)
        games_list = []
        @games.each do |game|
          games_list.push(game) if game[:home_team_id] == team_id || game[:away_team_id] == team_id
          end
          games_in_a_season = games_list.group_by { |game| game[:season] }
          season_win_percent = Hash.new (0)
          games_in_a_season.each do |season, games|
            home_wins = games.find_all do |game|
              game[:home_team_id] == team_id && game[:home_goals] > game[:away_goals]
            end
            away_wins = games.find_all do |game|
              game[:away_team_id] == team_id && game[:home_goals] < game[:away_goals]
            end
            season_win_percent[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
        end
        season_win_percent ||= season_win_percent[:team_id].to_i
        season_win_percent.key(season_win_percent.values.max_by { |percentage| percentage })
      end

    def worst_season(team_id)
        games_list = []
        @games.each do |game|
          games_list.push(game) if game[:home_team_id] == team_id || game[:away_team_id] == team_id
          end
          games_in_a_season = games_list.group_by { |game| game[:season] }
          season_win_percent = Hash.new (0)
          games_in_a_season.each do |season, games|
            home_wins = games.find_all do |game|
              game[:home_team_id] == team_id && game[:home_goals] > game[:away_goals]
            end
            away_wins = games.find_all do |game|
              game[:away_team_id] == team_id && game[:home_goals] < game[:away_goals]
            end
            season_win_percent[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
        end
        season_win_percent ||= season_win_percent[:team_id].to_i
        season_win_percent.key(season_win_percent.values.min_by { |percentage| percentage })
    end

    def average_win_percentage(team_id)
        game_teams_id = @game_teams.find_all { |team| team[:team_id] == team_id }
        team_results = Hash.new { |hash, key| hash[key] = [] }
        @game_teams.each do |game|
            team_results[game[:team_id]] << game[:result]
        end
        team_wins = team_results[team_id].select do |result|
            result == "WIN"
        end
        (team_wins.count.to_f / team_results[team_id].count.to_f).round(2)
    end
    
    def favorite_opponent(team_id)
        rival_stats = Hash.new { |h,k| h[k] = Hash.new(0) }
        @games.each do |game|
            if game[:home_team_id] == team_id || game[:away_team_id] == team_id
                if (game[:home_team_id] == team_id)
                    rival = rival_stats[game[:away_team_id]]
                    rival[:total_games] += 1.0
                    if game[:home_goals] < game[:away_goals] 
                        rival[:losses] += 1.0    
                    end
                elsif (game[:away_team_id] == team_id)
                    rival = rival_stats[game[:home_team_id]]
                    rival[:total_games] += 1.0
                    if game[:home_goals] > game[:away_goals] 
                        rival[:losses] += 1.0  
                    end
                end
            end
        end

        loss_percentage = Hash.new(0)
        rival_stats.each do |rival_team_id, stats|
            loss_percentage[rival_team_id] = stats[:losses] / stats[:total_games]
        end

        rival_id = loss_percentage.min_by { |rival_team_id, loss_percentage| loss_percentage }[0]
        @teams.find { |team| team[:team_id] == rival_id }[:teamname]
    end
    
    def rival(team_id)
        rival_stats = Hash.new { |h,k| h[k] = Hash.new(0) }
        @games.each do |game|
            if game[:home_team_id] == team_id || game[:away_team_id] == team_id
                if (game[:home_team_id] == team_id)
                    rival = rival_stats[game[:away_team_id]]
                    # require "pry"; binding.pry
                    rival[:total_games] += 1.0
                    if game[:home_goals] < game[:away_goals] 
                        rival[:losses] += 1.0    
                    end
                elsif (game[:away_team_id] == team_id)
                    rival = rival_stats[game[:home_team_id]]
                    rival[:total_games] += 1.0
                    if game[:home_goals] > game[:away_goals] 
                        rival[:losses] += 1.0  
                    end
                end
            end
        end
        loss_percentage = Hash.new(0)
        rival_stats.each do |rival_team_id, stats|
            loss_percentage[rival_team_id] = stats[:losses] / stats[:total_games]
        end
        rival_id = loss_percentage.max_by { |rival_team_id, loss_percentage| loss_percentage }[0]
        @teams.find { |team| team[:team_id] == rival_id }[:teamname]
    end
end
