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

    #select games team lost and delete result
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

  #Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value.	Hash
  #AM
  def head_to_head(team_id)
    #your beautiful code
  end

  #For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.	Hash
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


end
