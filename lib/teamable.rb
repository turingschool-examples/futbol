module Teamable

  #A hash with key/value pairs for each of the attributes of a team.	Hash
  #JP
  def team_info(team_id)
    #your beautiful code
  end

  #Season with the highest win percentage for a team.	Integer
  #JP
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

  def total_wins_helper2(team_id, loser_team_id)

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

  def total_games_helper2(team_id, opponent_team_id)

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
