require 'pry'

module Teamable

  #A hash with key/value pairs for each of the attributes of a team.	Hash
  #JP

  def team_info(teamid)
    team_info_hash = Hash.new
    iv_name_array = []
    iv_values_array = []

    self.teams.each do |team_id, team_obj|
      if team_id == teamid
        iv_name_array = team_obj.instance_variables

        until iv_name_array == []
            iv_values_array << team_obj.instance_variable_get("#{iv_name_array[0]}")
            iv_name_array[1].to_s.gsub!(/franchiseId/, "franchise_id")
            iv_name_array[2].to_s.gsub!(/teamName/, "team_name")
            team_info_hash[iv_name_array.shift.to_s[1..-1]] = iv_values_array.shift
        end
      end
    end
    team_info_hash.delete("stadium")
    team_info_hash
  end

  def best_season(team_id)
    #your beautiful code
  end

  #Season with the lowest win percentage for a team.	Integer
  #JP
  def worst_season(team_id)
    #your beautiful code
  end

  #Average win percentage of all games for a team.	Float
  #JP
  def average_win_percentage(team_id)
    #your beautiful code
  end

  #Highest number of goals a particular team has scored in a single game.	Integer
  #BB
  def most_goals_scored(team_id)
    #your beautiful code
  end

  #Lowest numer of goals a particular team has scored in a single game.	Integer
  #BB
  def fewest_goals_scored(team_id)
    #your beautiful code
  end

  #Name of the opponent that has the lowest win percentage against the given team.	String
  #BB
  def favorite_opponent(team_id)
    #your beautiful code
  end

  #Name of the opponent that has the highest win percentage against the given team.	String
  #BB
  def rival(team_id)
    #your beautiful code
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
    losses = games_for_team_helper(team_id).select! do |game|
      if (game.away_team_id == team_id) && (game.away_goals < game.home_goals)
        true
      elsif (game.home_team_id == team_id) && (game.home_goals < game.away_goals)
        true
      else
        false
      end
    end

    max_game = losses.max_by do |game|
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
      elsif (opponent_teams.has_key?(game.away_team_id) == false)
        opponent_teams.store(game.away_team_id, team_name_finder_helper(game.away_team_id))
      end
    end

    #iterate over teams played and calculate win percentage for each
    opponent_teams.each do |opponent_team_id, opponent_team_name|
      output[opponent_team_name] = (total_wins_helper(team_id, opponent_team_id) / total_games_helper(team_id, opponent_team_id)).round(2)
    end

    output
  end

  #For each season that the team has played, a hash that has two keys
  #(:regular_season and :postseason), that each point to a hash with the
  #following keys: :win_percentage, :total_goals_scored,
  #:total_goals_against, :average_goals_scored, :average_goals_against.	Hash
  #AM
  def seasonal_summary(team_id)
    #your beautiful code
  end

  #get games for a team_id
  def games_for_team_helper(team_id)

      games_for_team = []

      self.games.each_value do |game|
        if game.away_team_id == team_id || game.home_team_id == team_id
          games_for_team << game
        end
      end

      games_for_team
  end

  def total_wins_helper(team_id, loser_team_id)

    #select games team won and delete rest
    games_for_team_helper(team_id).select! do |game|
      if (game.away_team_id == loser_team_id) || (game.home_team_id == loser_team_id)
        if (game.away_team_id == team_id) && (game.away_goals > game.home_goals)
          true
        elsif (game.home_team_id == team_id) && (game.home_goals > game.away_goals)
          true
        else
          false
        end
      end
    end.length.to_f
  end

  def total_games_helper(team_id, opponent_team_id)

    # can't get this to work for some reason!!!!!!!
    # games_for_team_helper(team_id).select! do |game|
      # require 'pry'; binding.pry
      # (game.away_team_id == opponent_team_id) ||
      # (game.home_team_id == opponent_team_id)

    # end.length

    total_games = []
    games_for_team_helper(team_id).each do |game|
      if game.away_team_id == opponent_team_id
        total_games << game
      elsif game.home_team_id == opponent_team_id
        total_games << game
      end
    end

    total_games.length


  end



end
