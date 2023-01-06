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
        
        hash1 = Hash.new { |hash, key| hash[key] = [] }
        @game_teams.each do |info|
            hash1[info[:team_id]] << info[:goals]
        end

        hash2 = Hash.new { |hash, key| hash[key] = [] }
        hash1.each do |id, goals|
            hash2[id] = (goals.sum / goals.count.to_f).round(2)
        end
         
        @teams.find do |info|
            # .find will return first highest avg, .each will return last highest avg
            if info[:team_id] == hash2.key(hash2.values.max)
                return info[:teamname]
            end
        end
    end

    
    def worst_offense
        # Return team with lowest average number of goals over all total games
        
        hash1 = Hash.new { |hash, key| hash[key] = [] }
        @game_teams.each do |info|
            hash1[info[:team_id]] << info[:goals]
        end

        hash2 = Hash.new { |hash, key| hash[key] = [] }
        hash1.each do |id, goals|
            hash2[id] = (goals.sum / goals.count.to_f).round(2)
        end
        # require 'pry'; binding.pry
        
        @teams.find do |info|
            if info[:team_id] == hash2.key(hash2.values.min)
                return info[:teamname]
            end
        end
    end
end

     # @game_teams.group_by { |game_team| game_team[:team_id] }.keys

# Find all the goals for each team(hash)
# sum of them, and divide by total elements (average)
# iterate through hash of team ids and averages - find max or min value
# iterate through teams.csv & match team id with team name
# if team id inside of teams csv file matches team id hash with avg goals,
# call max value on second array

# if the team id in the teams file has the same id as the one in the array with the max value
# return that team name

# home team total scores
# away team total scores

# Make 2 hashes - 
# away team id with away goals


# home team id w home goals
# Set to another hash sorted by team id and sum of the away and home goals for that Id