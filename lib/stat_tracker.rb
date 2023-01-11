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
       @games.percentage_home_wins
    end

    def percentage_visitor_wins
        @games.percentage_visitor_wins
    end

    def percentage_ties
        @games.percentage_ties
    end

    def count_of_games_by_season
        @games.count_of_games_by_season
    end

    def average_goals_per_game
        @games.average_goals_per_game                   
    end

    def average_goals_by_season
        @games.average_goals_by_season
    end
    
    def count_of_teams
        @teams.count_of_teams
    end

    def best_offense
        @teams.get_team_name(@game_teams.highest_avg_goals_by_team)
    end

    def worst_offense
        @teams.get_team_name(@game_teams.lowest_avg_goals_by_team)
    end

    def highest_scoring_visitor
       @game_teams.highest_scoring_visitor
    end

    def highest_scoring_home_team
        @game_teams.highest_scoring_home_team
    end

    def lowest_scoring_visitor
        @game_teams.lowest_scoring_visitor
    end

    def lowest_scoring_home_team
        @game_teams.lowest_scoring_home_team
    end

    def winningest_coach(season_id)
        @game_teams.winningest_coach(season_id)
    end

    def worst_coach(season_id)
        @game_teams.worst_coach(season_id)
    end

    def most_accurate_team(season)
      @game_teams.most_accurate_team(season)
    end

    def least_accurate_team(season)
       @game_teams.least_accurate_team(season)
    end

    def most_tackles(season_id)
        @game_teams.most_tackles(season_id)
    end

    def fewest_tackles(season_id)
       @game_teams.fewest_tackles(season_id)
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
