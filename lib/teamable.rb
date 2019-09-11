module Teamable

  #A hash with key/value pairs for each of the attributes of a team.	Hash
  #JP (Complete)
  def team_info(teamid)
    team_info_hash = Hash.new
    iv_name_array = []
    iv_values_array = []

    self.teams.each do |team_id, team_obj|
      if team_id == teamid
        iv_name_array = team_obj.instance_variables

        until iv_name_array == []
            iv_values_array << team_obj.instance_variable_get("#{iv_name_array[0]}")
            team_info_hash[iv_name_array.shift.to_s[1..-1]] = iv_values_array.shift
        end
      end
    end
    team_info_hash.delete("stadium")
    team_info_hash
  end

  #Season with the highest win percentage for a team.	Integer
  #JP (Complete)
  def best_season(team_id)
    season_win_percentage_hash = season_win_percentage_helper(team_id)
    best_win_percentage = 0.0
    best_season = 0

    season_win_percentage_hash.each do |season, win_percentage|
      if win_percentage > best_win_percentage
       best_win_percentage = win_percentage
      end
      best_season = season_win_percentage_hash.key(best_win_percentage)
    end
    best_season
  end

  #Season with the lowest win percentage for a team.	Integer
  #JP (Complete)
  def worst_season(team_id)
    season_win_percentage_hash = season_win_percentage_helper(team_id)
    worst_win_percentage = 2.0
    worst_season = 0

    season_win_percentage_hash.each do |season, win_percentage|
      if win_percentage < worst_win_percentage
       worst_win_percentage = win_percentage
      end
      worst_season = season_win_percentage_hash.key(worst_win_percentage)
    end
    worst_season
  end

  #Average win percentage of all games for a team.	Float
  #JP (Complete, renamed helper methods will have to be adjusted)
  def average_win_percentage(team_id)
    (total_wins_count_helper(team_id) / games_for_team_helper(team_id).length.to_f).round(2)
  end

  #Highest number of goals a particular team has scored in a single game.	Integer
  #BB (Complete)
  def most_goals_scored(team_id)
    most_goals_scored_counter = 0
    int_team_id = team_id.to_i
    self.game_teams.each do |game_team_obj|
      if game_team_obj.team_id == int_team_id
        if game_team_obj.goals > most_goals_scored_counter
          most_goals_scored_counter = game_team_obj.goals
        end
      end
    end
    most_goals_scored_counter
  end

  #Lowest numer of goals a particular team has scored in a single game.	Integer
  #BB (Complete)
  def fewest_goals_scored(team_id)
    fewest_goals_scored_counter = 100
    int_team_id = team_id.to_i
    self.game_teams.each do |game_team_obj|
      if game_team_obj.team_id == int_team_id
        if game_team_obj.goals < fewest_goals_scored_counter
          fewest_goals_scored_counter = game_team_obj.goals
        end
      end
    end
    fewest_goals_scored_counter
  end

  #Name of the opponent that has the lowest win percentage against the given team.	String
  #BB
  def favorite_opponent(team_id)

    # creates a hash full of opponent ids and sets the values to 0
    opponents_number_of_wins = Hash.new(0.00)
    games_for_team_helper(team_id).each do |game|
      opponents_number_of_wins.store(game.away_team_id, 0.00) if game.away_team_id != team_id
      opponents_number_of_wins.store(game.home_team_id, 0.00) if game.home_team_id != team_id
    end

    # set the value to the number of wins over
    opponents_number_of_wins.each do |key, value|
       opponents_number_of_wins[key] = total_wins_count_helper(team_id, key)
    end

    # creates a hash full of opponent ids and sets the values to 0
    opponents_number_of_games = Hash.new(0.00)
    games_for_team_helper(team_id).each do |game|
      opponents_number_of_games.store(game.away_team_id, 0.00) if game.away_team_id != team_id
      opponents_number_of_games.store(game.home_team_id, 0.00) if game.home_team_id != team_id
    end

    # set the value to the number of games played
    opponents_number_of_games.each do |key, value|
       opponents_number_of_games[key] = total_games_count_helper(team_id, key)
    end

    # make a new hash to check the percent of wins against the passed in team
    opponents_percentage_of_wins = Hash.new(0.00)
    games_for_team_helper(team_id).each do |game|
      opponents_percentage_of_wins.store(game.away_team_id, 0.00) if game.away_team_id != team_id
      opponents_percentage_of_wins.store(game.home_team_id, 0.00) if game.home_team_id != team_id
    end

    # Check for matching team ids and return the percent of games won for that team
    opponents_percentage_of_wins.each do |key_3, value_3|
      opponents_number_of_wins.each do |key_1, value_1|
        opponents_number_of_games.each do |key_2, value_2|
          if key_1 == key_2 && key_1 == key_3
            opponents_percentage_of_wins[key_3] = (value_1 / value_2)
          end
        end
      end
    end

    # find the max percent id from the opponents_percentage_of_wins hash
    favorite_opponent_id = opponents_percentage_of_wins.max_by{|k,v| v}
    favorite_opponent = favorite_opponent_id[0]

    team_name_finder_helper(favorite_opponent)

  end


  #Name of the opponent that has the highest win percentage against the given team.	String
  #BB
  def rival(team_id)
    # creates a hash full of opponent ids and sets the values to 0
    opponents_number_of_wins = Hash.new(0.00)
    games_for_team_helper(team_id).each do |game|
      opponents_number_of_wins.store(game.away_team_id, 0.00) if game.away_team_id != team_id
      opponents_number_of_wins.store(game.home_team_id, 0.00) if game.home_team_id != team_id
    end

    # set the value to the number of wins over
    opponents_number_of_wins.each do |key, value|
       opponents_number_of_wins[key] = total_wins_count_helper(team_id, key)
    end

    # creates a hash full of opponent ids and sets the values to 0
    opponents_number_of_games = Hash.new(0.00)
    games_for_team_helper(team_id).each do |game|
      opponents_number_of_games.store(game.away_team_id, 0.00) if game.away_team_id != team_id
      opponents_number_of_games.store(game.home_team_id, 0.00) if game.home_team_id != team_id
    end

    # set the value to the number of games played
    opponents_number_of_games.each do |key, value|
       opponents_number_of_games[key] = total_games_count_helper(team_id, key)
    end

    # make a new hash to check the percent of wins against the passed in team
    opponents_percentage_of_wins = Hash.new(0.00)
    games_for_team_helper(team_id).each do |game|
      opponents_percentage_of_wins.store(game.away_team_id, 0.00) if game.away_team_id != team_id
      opponents_percentage_of_wins.store(game.home_team_id, 0.00) if game.home_team_id != team_id
    end

    # Check for matching team ids and return the percent of games won for that team
    opponents_percentage_of_wins.each do |key_3, value_3|
      opponents_number_of_wins.each do |key_1, value_1|
        opponents_number_of_games.each do |key_2, value_2|
          if key_1 == key_2 && key_1 == key_3
            opponents_percentage_of_wins[key_3] = (value_1 / value_2)
          end
        end
      end
    end

    # find the max percent id from the opponents_percentage_of_wins hash
    favorite_opponent_id = opponents_percentage_of_wins.min_by{|k,v| v}
    favorite_opponent = favorite_opponent_id[0]

    team_name_finder_helper(favorite_opponent)
  end

  #Biggest difference between team goals and opponent goals for a win
  #for the given team.	Integer
  #AM (complete)
  def biggest_team_blowout(team_id)

    #select games team won and delete result
    wins = games_for_team_helper(team_id).select! do |game|
      if (game.away_team_id == team_id) && (game.away_goals > game.home_goals)
        true
      elsif (game.home_team_id == team_id) && (game.home_goals > game.away_goals)
        true
      else
        false
      end
    end

    max_game = wins.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end

    (max_game.home_goals - max_game.away_goals).abs

  end

  #Biggest difference between team goals and opponent goals for a
  #loss for the given team.	Integer
  #AM (complete)
  def worst_loss(team_id)

    #select games team lost and delete rest
    games = games_for_team_helper(team_id).select! do |game|
      if (game.away_team_id == team_id) && (game.away_goals < game.home_goals)
        true
      elsif (game.home_team_id == team_id) && (game.home_goals < game.away_goals)
        true
      else
        false
      end
    end

    max_game = games.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end

    (max_game.home_goals - max_game.away_goals).abs

  end

  #Record (as a hash - win/loss) against all opponents with the opponents’ names
  #as keys and the win percentage against that opponent as a value.	Hash
  #AM (completed, but not in same order as spec spec_harness)
  def head_to_head(team_id)
    games_played = games_for_team_helper(team_id)
    opponent_teams = Hash.new(0)

    #fill hash with teams played
    output = Hash.new(0)

    #get unique opponent team id and name
    games_played.each do |game|
      if (opponent_teams.has_key?(game.home_team_id) == false) && (game.home_team_id != team_id)
        opponent_teams.store(game.home_team_id, team_name_finder_helper(game.home_team_id))
      elsif (opponent_teams.has_key?(game.away_team_id) == false) && (game.away_team_id != team_id)
        opponent_teams.store(game.away_team_id, team_name_finder_helper(game.away_team_id))
      end
    end

    #iterate over teams played and calculate win percentage for each
    opponent_teams.each do |opponent_team_id, opponent_team_name|
      output[opponent_team_name] = (total_wins_count_helper(team_id, opponent_team_id) / total_games_count_helper(team_id, opponent_team_id)).round(2)
    end

    output
  end

  #For each season that the team has played, a hash that has two keys
  #(:regular_season and :postseason), that each point to a hash with the
  #following keys: :win_percentage, :total_goals_scored,
  #:total_goals_against, :average_goals_scored, :average_goals_against.	Hash
  #AM
  def seasonal_summary(team_id)
    unique_seasons = []

    self.games.each_value do |game|
      unique_seasons << game.season if (game.home_team_id == team_id) || (game.away_team_id == team_id)
    end
    unique_seasons = unique_seasons.uniq

    seasonal_summary_hash = Hash.new(0)
    unique_seasons.each do |season|
     # binding.pry
      seasonal_summary_hash[season] = {:postseason =>
        {:win_percentage => season_type_win_percentage_helper(team_id, season, "Postseason").round(2),
         :total_goals_scored => season_type_goals_scored_helper(team_id, season, "Postseason"),
         :total_goals_against => season_type_goals_against_helper(team_id, season, "Postseason"),
         :average_goals_scored => season_type_average_goals_scored_helper(team_id, season, "Postseason"),
         :average_goals_against => season_type_average_goals_against_helper(team_id, season, "Postseason")
        },

        :regular_season =>
          {:win_percentage => season_type_win_percentage_helper(team_id, season, "Regular Season").round(2),
           :total_goals_scored => season_type_goals_scored_helper(team_id, season, "Regular Season"),
           :total_goals_against => season_type_goals_against_helper(team_id, season, "Regular Season"),
           :average_goals_scored => season_type_average_goals_scored_helper(team_id, season, "Regular Season"),
           :average_goals_against => season_type_average_goals_against_helper(team_id, season, "Regular Season")
          }
      }
    end
    seasonal_summary_hash

  end


end
