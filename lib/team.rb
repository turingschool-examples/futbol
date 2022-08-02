require_relative 'global_module'

class TeamStatistics
    include Globeable

    def initialize(teams_data, games_data, game_teams_data)
      @teams_data = teams_data
      @games_data = games_data
      @game_teams_data = game_teams_data
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

    def avg_win_pct(given_team_id)
      overall_record = season_record(given_team_id).values.transpose.map(&:sum)
      find_percentage(overall_record[0], (overall_record[0..2].sum))
    end

    def rival(given_team_id)
      wins_and_losses = head_to_head_records(given_team_id)
      rival_array = wins_and_losses.min_by { |team, array| (array[0] - array [1])}
      rival_team_id = find_team_name_by_id(fav_opponent_array[0])
      find_team_name_by_id(rival_team_id)
    end

    def favorite_opponent(given_team_id)
      wins_and_losses = head_to_head_records(given_team_id)
      fav_opponent_array = wins_and_losses.min_by { |team, array| (array[0] - array [1])}
      favorite_team_id = find_team_name_by_id(fav_opponent_array[0])
      find_team_name_by_id(favorite_team_id)
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
      ((numerator/denominator)*100).round(2)
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
          season_record_hash[game[:season]][2] += 1 #losses
        elsif game[:away_goals] < game[:home_goals]
          season_record_hash[game[:season]][0] += 1 #wins
        else
          season_record_hash[game[:season]][1] += 1 #ties
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

    def rival(given_team_id)
      wins_and_losses = head_to_head_records(given_team_id)
      rival_array = wins_and_losses.min_by { |team, array| (array[0] - array [1])}
      rival_team_id = find_team_name_by_id(fav_opponent_array[0])
      find_team_name_by_id(rival_team_id)
    end

    def favorite_opponent(given_team_id)
      wins_and_losses = head_to_head_records(given_team_id)
      fav_opponent_array = wins_and_losses.min_by { |team, array| (array[0] - array [1])}
      favorite_team_id = find_team_name_by_id(fav_opponent_array[0])
      find_team_name_by_id(favorite_team_id)
    end

    def head_to_head_records(given_team_id)
      home_games = home_games_by_team(given_team_id)
      away_games = away_games_by_team(given_team_id)
      wins_and_losses = Hash.new{|opposing_id, head_to_head| opposing_id[head_to_head] = [0.0, 0.0]}

      home_games.each do |game|
        if game[:away_goals] > game[:home_goals]
          wins_and_losses[game[:away_team_id]][1] += 1
        elsif game[:away_goals] < game[:home_goals]
          wins_and_losses[game[:away_team_id]][0] += 1
        else
          #tie
        end
      end

      away_games.each do |game|
        if game[:away_goals] > game[:home_goals]
          wins_and_losses[game[:home_team_id]][0] += 1
        elsif game[:away_goals] < game[:home_goals]
          wins_and_losses[game[:home_team_id]][1] += 1
        else
          #tie
        end
      end
      wins_and_losses.delete(given_team_id.to_s)
      wins_and_losses
    end
end