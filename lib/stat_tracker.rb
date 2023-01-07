require "csv"
# require_relative 'game'
# require_relative 'team'
# require_relative 'game_teams'


class StatTracker
    attr_reader :games,
                :teams,
                :game_teams

    def initialize(location_paths)
        @games = create_games_array(location_paths[:games])
        @teams = create_teams_array(location_paths[:teams])
        @game_teams = create_game_teams_array(location_paths[:game_teams])
    end

    def self.from_csv(location_paths)
        new(location_paths)
    end

    def create_games_array(game_path)
        games = []
        CSV.foreach(game_path, headers: true, header_converters: :symbol) do |info|
            game = info.to_h
            game[:away_goals] = game[:away_goals].to_i
            game[:home_goals] = game[:home_goals].to_i
            games << game
        end
        games
    end

    def create_teams_array(team_path)
      team = []
      CSV.foreach(team_path, headers: true, header_converters: :symbol) do |info|
          team << info.to_h
      end
      team
    end

    def create_game_teams_array(game_team_path)
      game_teams = []
      CSV.foreach(game_team_path, headers: true, header_converters: :symbol) do |info|
          game_team = info.to_h
          game_team[:goals] = game_team[:goals].to_i
          game_team[:shots] = game_team[:shots].to_i
          game_team[:tackles] = game_team[:tackles].to_i
          game_team[:pim] = game_team[:pim].to_i
          game_team[:powerplayopportunities] = game_team[:powerplayopportunities].to_i
          game_team[:powerplaygoals] = game_team[:powerplaygoals].to_i
          game_team[:faceoffwinpercentage] = game_team[:faceoffwinpercentage].to_f
          game_team[:giveaways] = game_team[:giveaways].to_i
          game_team[:takeaways] = game_team[:takeaways].to_i
          game_teams << game_team
        #   require "pry"; binding.pry
      end
      game_teams
    end


    def games_total_score_array
        games.map { |game| game[:away_goals] + game[:home_goals] }   
    end

    def highest_total_score
        # require "pry"; binding.pry
        games_total_score_array.max
    end

    def lowest_total_score
        games_total_score_array.min
    end
    
    def percentage_home_wins
        percentage_games = []
        @games.each do |game, goals|
            percentage_games << game if game[:away_goals] < game[:home_goals] 
        end
        (percentage_games.count.to_f / @games.count.to_f).round(2)
    end

    def percentage_visitor_wins
        percentage_games = []
        @games.each do |game, goals|
            percentage_games << game if game[:away_goals] > game[:home_goals] 
        end
        (percentage_games.count.to_f / @games.count.to_f).round(2)
    end

    def percentage_ties
        percentage_games = []
        @games.each do |game, goals|
            percentage_games << game if game[:away_goals] == game[:home_goals] 
        end
        (percentage_games.count.to_f / @games.count.to_f).round(2)
    end

    def count_of_games_by_season
        season_count = @games.group_by { |game| game[:season] }
        season_count.each do |games, value|
             season_count[games] = value.count         
        end
    end

    def average_goals_per_game
        (games_total_score_array.sum / @games.count.to_f).round(2)                    
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
        # Return team with highest average number of goals over all total games
        
        total_goals_by_team = Hash.new(0)
        @game_teams.each do |game|
            total_goals_by_team[game[:team_id]] += game[:goals]
        end

        avg_goals_by_team = Hash.new(0)
        total_goals_by_team.each do |id, total_goals|
            avg_goals_by_team[id] = (total_goals.to_f / @game_teams.find_all { |game| game[:team_id] == id }.length).round(2)
        end
         
        @teams.find do |game|
            # .find will return first highest avg, .each will return last highest avg
            if game[:team_id] == avg_goals_by_team.key(avg_goals_by_team.values.max)
                return game[:teamname]
            end
        end
    end

    def worst_offense
        # Return team with highest average number of goals over all total games
        
        total_goals_by_team = Hash.new(0)
        @game_teams.each do |game|
            total_goals_by_team[game[:team_id]] += game[:goals]
        end

        avg_goals_by_team = Hash.new(0)
        total_goals_by_team.each do |id, total_goals|
            avg_goals_by_team[id] = (total_goals.to_f / @game_teams.find_all { |game| game[:team_id] == id }.length).round(2)
        end
         
        @teams.find do |game|
            # .find will return first highest avg, .each will return last highest avg
            if game[:team_id] == avg_goals_by_team.key(avg_goals_by_team.values.min)
                return game[:teamname]
            end
        end
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
    
end
   

