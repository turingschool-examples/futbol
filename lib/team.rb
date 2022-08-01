# require './lib/team_module'
# require './lib/team_name_by_id_helper_module'

class TeamStatistics
    # include Teamable
    # include TeamNameable
    def initialize
      @teams_data = CSV.read "./data/teams.csv", headers: true, header_converters: :symbol
      @game_teams_data = CSV.read "./data/game_teams.csv", headers: true, header_converters: :symbol
      @games_data = CSV.read "./data/games.csv", headers: true, header_converters: :symbol
    end

    def team_info(given_team_id)
      all_team_info = @teams_data.select do |team|
        team[:team_id].to_s == given_team_id.to_s
      end[0].to_h
    end

    def fewest_goals_scored(given_team_id)
      goals_scored_by_game(given_team_id).min
    end

    def most_goals_scored(given_team_id)
        goals_scored_by_game(given_team_id).max
    end



    def worst_season(given_team_id)
      season_record(given_team_id).min_by { |season, record| record[0] / (record[2] + record [1]) }.first
    end

    def best_season(given_team_id)
      season_record(given_team_id).max_by { |season, record| record[0] / (record[2] + record [1]) }.first
    end

    ## HELPER METHODS
    def find_all_team_games(given_team_id)
      away_games_by_team(given_team_id) + home_games_by_team(given_team_id)
    end


    def away_games_by_team(given_team_id)
      @games_data.find_all do |team|
        team[:away_team_id] == given_team_id.to_s
      end
    end

    def home_games_by_team(given_team_id)
      @games_data.find_all do |team|
        team[:home_team_id] == given_team_id.to_s
      end
    end

    def find_team_name_by_id(id_number)
      team_name = nil
      @teams_data.each do |row|
        team_name = row[:teamname] if row[:team_id] == id_number.to_s
      end
      team_name
    end

    def find_percentage(numerator,denominator)
      (numerator/denominator)*100.round(2)
    end

    ## long helper methods -- continue shredding
    def goals_scored_by_game(given_team_id)
      home_games = home_games_by_team(given_team_id)
      away_games = away_games_by_team(given_team_id)
      goals_by_game = []
      home_games.each do |game|
        goals_by_game << game[:home_goals].to_i
      end
      away_games.each do |game|
        goals_by_game << game[:away_goals].to_i
      end
      goals_by_game
    end

    def season_record(given_team_id)
      away_games = away_games_by_team(given_team_id)
      home_games = home_games_by_team(given_team_id)
      season_record_hash = Hash.new{ |season, record | season[record] = [0.0, 0.0, 0.0] }

      home_games.each do |game|
        if game[:away_goals] > game[:home_goals]
          season_record_hash[game[:season]][2] += 1
        elsif game[:away_goals] < game[:home_goals]
          season_record_hash[game[:season]][0] += 1
        else
          season_record_hash[game[:season]][1] += 1
        end
      end

      away_games.each do |game|
        if game[:away_goals] > game[:home_goals]
          season_record_hash[game[:season]][0] += 1
        elsif game[:away_goals] < game[:home_goals]
          season_record_hash[game[:season]][2] += 1
        else
          season_record_hash[game[:season]][1] += 1
        end
      end
      season_record_hash
    end

end










#     def team_id_to_name(id)
#       @teams.find { |team| team.team_id == id }.team_name
#     end
#   end

