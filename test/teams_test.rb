require 'minitest/autorun'
require 'minitest/pride'
require_relative 'teams'

class TeamsTest < Minitest::Test

  #A hash with key/value pairs for each of the attributes of a team.	Hash
  #JP
  def test_team_info
    #your beautiful code
  end

  #Season with the highest win percentage for a team.	Integer
  #JP
  def test_best_season
    #your beautiful code
  end

  #Season with the lowest win percentage for a team.	Integer
  #JP
  def test_worst_season
    #your beautiful code
  end

  #Average win percentage of all games for a team.	Float
  #JP
  def test_average_win_percentage
    #your beautiful code
  end

  #Highest number of goals a particular team has scored in a single game.	Integer
  #BB
  def test_most_goals_scored
    #your beautiful code
  end

  #Lowest numer of goals a particular team has scored in a single game.	Integer
  #BB
  def test_fewest_goals_scored
    #your beautiful code
  end

  #Name of the opponent that has the lowest win percentage against the given team.	String
  #BB
  def test_favorite_opponent
    #your beautiful code
  end

  #Name of the opponent that has the highest win percentage against the given team.	String
  #BB
  def test_rival
    #your beautiful code
  end

  #Biggest difference between team goals and opponent goals for a win for the given team.	Integer
  #AM
  def test_biggest_team_blowout
    #your beautiful code
  end

  #Biggest difference between team goals and opponent goals for a loss for the given team.	Integer
  #AM
  def test_worst_loss
    #your beautiful code
  end

  #Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value.	Hash
  #AM
  def test_head_to_head
    #your beautiful code
  end

  #For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.	Hash
  #AM
  def test_seasonal_summary
    #your beautiful code
  end

end
