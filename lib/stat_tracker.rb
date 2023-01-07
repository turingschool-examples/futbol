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

    def did_win(game)
        game[:home_goals] > game[:away_goals]
    end

    def best_season(team_id)
        games = @games.find_all { |team| team[:home_team_id] == team_id }
        game_teams = @game_teams.find_all { |team| team[:team_id] == team_id }
        game_teams_by_season = games.group_by { |game| game[:season] }
        # binding.pry

        season_percentages = []
        game_teams_by_season.each do |season, season_games|
            percent_wins_by_season = (season_games.count { |game| did_win(game) } / season_games.length.to_f).round(2)
            season_with_percent = Hash.new(0)
            season_with_percent[season] = percent_wins_by_season
            season_percentages << season_with_percent
        end
       
        highest_percent_w_season = nil
        season_percentages.each do |season_w_percent|
            percent_wins = season_w_percent.values.max
            if highest_percent_w_season
                highest_percent_w_season = season_w_percent if percent_wins > highest_percent_w_season.values.max
            else
                highest_percent_w_season = season_w_percent
            end
        end
        highest_percent_w_season.keys[0]
    end

    def did_lose(game)
        game[:home_goals] < game[:away_goals]
    end

    def worst_season(team_id)
        games = @games.find_all { |team| team[:home_team_id] == team_id }
        game_teams = @game_teams.find_all { |team| team[:team_id] == team_id }
        game_teams_by_season = games.group_by { |game| game[:season] }
        # binding.pry

        season_percentages = []
        game_teams_by_season.each do |season, season_games|
            percent_wins_by_season = (season_games.count { |game| did_lose(game) } / season_games.length.to_f).round(2)
            season_with_percent = Hash.new(0)
            season_with_percent[season] = percent_wins_by_season
            season_percentages << season_with_percent
            # binding.pry
        end
       
        lowest_percent_w_season = {"initial_value" => 1}
        season_percentages.each do |season_w_percent|
            percent_wins = season_w_percent.values[0]
            lowest_percent_w_season = season_w_percent if percent_wins < lowest_percent_w_season.values[0]
            # binding.pry
        end
        lowest_percent_w_season.keys[0]
    end

    def favorite_opponent(team_id)
        wins_vs_opponent = Hash.new(0)
        @games.each do |team|
            if team[:home_team_id] || team[:away_team_id] == team_id
                if (team[:home_team_id] == team_id) && (team[:home_goals] > team[:away_goals])
                 wins_vs_opponent[team[:away_team_id]] += 1.0
                    # require "pry"; binding.pry
                else (team[:away_team_id] == team_id) && (team[:away_goals] > team[:home_goals])
                    wins_vs_opponent[team[:home_team_id]] += 1.0
                end
            end
        end
        most_wins = wins_vs_opponent.key(wins_vs_opponent.values.max)
    
        favorite_opponent = @teams.find { |team| team[:teamname] if team[:team_id] == most_wins }
        favorite_opponent[:teamname]
    end
end
