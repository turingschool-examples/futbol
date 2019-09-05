#require './lib/stat_tracker'

module Teamable

  #A hash with key/value pairs for each of the attributes of a team.	Hash
  #JP
  def team_info
    #your beautiful code
  end

  #Season with the highest win percentage for a team.	Integer
  #JP
  def best_season
    #your beautiful code
  end

  #Season with the lowest win percentage for a team.	Integer
  #JP
  def worst_season
    #your beautiful code
  end

  #Average win percentage of all games for a team.	Float
  #JP
  def average_win_percentage
    #your beautiful code
  end

  #Highest number of goals a particular team has scored in a single game.	Integer
  #BB
  def most_goals_scored
    #your beautiful code
  end

  #Lowest numer of goals a particular team has scored in a single game.	Integer
  #BB
  def fewest_goals_scored
    #your beautiful code
  end

  #Name of the opponent that has the lowest win percentage against the given team.	String
  #BB
  def favorite_opponent
    #your beautiful code
  end

  #Name of the opponent that has the highest win percentage against the given team.	String
  #BB
  def rival
    #your beautiful code
  end

  #Biggest difference between team goals and opponent goals for a win for the given team.	Integer
  #AM
  def biggest_team_blowout
    #your beautiful code
  end

  #Biggest difference between team goals and opponent goals for a loss for the given team.	Integer
  #AM
  def worst_loss
    #your beautiful code
  end

  #Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value.	Hash
  #AM
  def head_to_head
    #your beautiful code
  end

  #For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.	Hash
  #AM
  def seasonal_summary
    #your beautiful code
  end

end
