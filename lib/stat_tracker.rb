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
      end
      game_teams
    end


    def games_total_score_array
        games.map { |game| game[:away_goals] + game[:home_goals] }   
    end

    def highest_total_score
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
  
    end

    def lowest_scoring_visitor

    end

    def lowest_scoring_home_team

    end

    def team_info(team_id)
        requested_team_info = @teams.find_all { |team| team[:team_id] == team_id }
        
        team_id_hash = {
            "team_id" => requested_team_info[0][:team_id],
            "franchise_id" => requested_team_info[0][:franchiseid],
            "team_name" => requested_team_info[0][:teamname],
            "abbreviation" => requested_team_info[0][:abbreviation],
            "link" => requested_team_info[0][:link]
        }
        team_ihd_ash 
    end

    def best_season(team_id)
        game_teams_id = @game_teams.find_all { |team| team[:team_id] == team_id }
        
        game_teams_by_season = game_teams_id.group_by { |game| game[:game_id] }
        game_teams_by_season.each do |key, value|
            total_wins_by_season = value.count { |element| element[:result] == "WIN" }/value.length.to_f
            game_teams_by_season[key] = total_wins_by_season
            # require "pry"; binding.pry
        end
        game_teams_by_season.key(game_teams_by_season.values.max)
        team_best_season = @games.find do |game| 
            game[:season] if game[:game_id] == game_teams_by_season.key(1) 
        end
        team_best_season[:season]
    end

end
